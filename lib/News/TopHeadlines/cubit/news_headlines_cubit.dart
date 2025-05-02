import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Model/error/error_m.dart';
import 'package:news/Model/filter/news_filter_m.dart';
import 'package:news/Model/news/news_model.dart';
import 'package:news/api/api_const.dart';
import 'package:news/api/dio.dart';
import 'package:news/helper/hive/BD/hive.dart';
import 'package:news/helper/hive/BD/news/news_model_mapper.dart';

part 'news_headlines_state.dart';

class NewsHeadlinesCubit extends Cubit<NewsHeadlinesState> {
  NewsHeadlinesCubit() : super(NewsInitial());
  static NewsHeadlinesCubit get(context) => BlocProvider.of(context);
  NewsModel? newsModel;

  Future<void> getNewsHeadline({
    NewsFilterModel? filter,
    String keyword = 'latest',
    int page = 1,
    bool isLoadMore = false,
  }) async {
    if (!isLoadMore) emit(NewsHeadlinesStateLoading());

    if (page == 1) {
      final cached = HiveDB.getTopHeadlines();
      if (cached != null) {
        newsModel = cached.toFreezedModel();
        print(newsModel?.articles?.length);

        emit(NewsHeadlinesStateSuccess(newsModel!, page));
      }
    }

    final query = {
      'q': keyword,
      'from': filter?.from?.toIso8601String(),
      'to': filter?.to?.toIso8601String(),
      'page': page.toString(),
      'pageSize': 20,
      'sources': filter?.source,
    };

    try {
      final value = await VPSDio.get(
        path: ApiConst.topHeadlines,
        queryParameters: query,
      );

      if (value.statusCode == 200) {
        final freshNews = NewsModel.fromJson(value.data);

        if (page == 1) {
          HiveDB.saveTopHeadlines(freshNews.toHiveModel());
          newsModel = freshNews;
          emit(NewsHeadlinesStateSuccess(newsModel!, page));
        } else {
          final currentState = state;
          if (currentState is NewsHeadlinesStateSuccess) {
            final combinedArticles = [
              ...currentState.newsModel.articles ?? [],
              ...freshNews.articles ?? [],
            ];
            newsModel = freshNews.copyWith(
              articles: combinedArticles.cast<ArticleModel>(),
            );
            emit(NewsHeadlinesStateSuccess(newsModel!, page));
          }
        }
      } else {
        emit(NewsHeadlinesStateError(ErrorModel.fromJson(value.data).message));
      }
    } catch (error) {
      if (page == 1) {
        emit(NewsHeadlinesStateBad());
      }
    }
  }
}
