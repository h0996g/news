import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Model/news/news_model.dart';
import 'package:news/api/api_const.dart';
import 'package:news/api/dio.dart';
import 'package:news/helper/hive/BD/hive.dart';
import 'package:news/helper/hive/BD/news/news_model_mapper.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());
  static NewsCubit get(context) => BlocProvider.of(context);
  Future<void> getNewsEverything({
    String? fromDate,
    String? toDate,
    String? source,
    String keyword = 'latest',
    int page = 1,
    bool isLoadMore = false,
  }) async {
    bool emittedCache = false;

    if (!isLoadMore) emit(NewsEverythingStateLoading());

    // ✅ Use cached data only if page 1
    if (page == 1) {
      final cached = HiveDB.getNews();
      if (cached != null) {
        emit(NewsEverythingStateSuccess(cached.toFreezedModel(), page));
        emittedCache = true;
      }
    }

    final query = {
      'q': keyword,
      'from': fromDate,
      'to': toDate,
      'page': page.toString(),
      'pageSize': 100,
      if (source != null && source.isNotEmpty) 'sources': source,
    };

    try {
      final value = await VPSDio.get(
        path: ApiConst.everything,
        queryParameters: query,
      );

      if (value.statusCode == 200) {
        final freshNews = NewsModel.fromJson(value.data);

        if (page == 1) {
          HiveDB.saveNews(freshNews.toHiveModel());
          emit(NewsEverythingStateSuccess(freshNews, page));
        } else {
          final currentState = state;
          if (currentState is NewsEverythingStateSuccess) {
            final combinedArticles = [
              ...currentState.newsModel.articles ?? [],
              ...freshNews.articles ?? [],
            ];
            final mergedModel = freshNews.copyWith(
              articles: combinedArticles.cast<ArticleModel>(),
            );
            emit(NewsEverythingStateSuccess(mergedModel, page));
          }
        }
      } else {
        if (!emittedCache) {
          emit(
            NewsEverythingStateError(value.statusMessage ?? 'Unknown error'),
          );
        }
      }
    } catch (error) {
      if (!emittedCache && page == 1) {
        emit(NewsEverythingStateBad());
      }
    }
  }
}
