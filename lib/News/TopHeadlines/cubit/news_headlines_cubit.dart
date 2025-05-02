import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Model/error/error_m.dart';
import 'package:news/Model/news/news_model.dart';
import 'package:news/api/api_const.dart';
import 'package:news/api/dio.dart';
import 'package:news/const/const.dart';
import 'package:news/helper/hive/BD/hive.dart';
import 'package:news/helper/hive/BD/news/news_model_mapper.dart';

part 'news_headlines_state.dart';

class NewsHeadlinesCubit extends Cubit<NewsHeadlinesState> {
  NewsHeadlinesCubit() : super(NewsInitial());
  static NewsHeadlinesCubit get(context) => BlocProvider.of(context);
  NewsModel? newsModel;

  Future<void> getNewsHeadline({
    String keyword = 'all',
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
      'from': defaultHeadlinesFilter?.from?.toIso8601String(),
      'to': defaultHeadlinesFilter?.to?.toIso8601String(),
      'page': page.toString(),
      'pageSize': 20,
      'sources': defaultHeadlinesFilter?.source,
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
            if ((freshNews.articles?.isEmpty ?? true)) {
              emit(NewsHeadlinesStateError("No more articles available."));
              return;
            }

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
        ErrorModel errorModel = ErrorModel.fromJson(value.data);
        emit(NewsHeadlinesStateError(errorModel.message));
      }
    } catch (error) {
      if (page == 1) {
        emit(NewsHeadlinesStateBad());
      }
    }
  }
}
