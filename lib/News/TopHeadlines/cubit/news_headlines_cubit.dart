import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Model/news/news_model.dart';
import 'package:news/News/function.dart/get_news_f.dart';
import 'package:news/api/api_const.dart';
import 'package:news/api/dio.dart';
import 'package:news/const/const.dart';
import 'package:news/helper/hive/hive.dart';
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
    final query = {
      'q': keyword,
      'from': defaultHeadlinesFilter?.from?.toIso8601String(),
      'to': defaultHeadlinesFilter?.to?.toIso8601String(),
      'page': page.toString(),
      'pageSize': pageSize,
      'sources': defaultHeadlinesFilter?.source,
    };
    await fetchNewsData<NewsHeadlinesState>(
      emitFunction: (state) => emit(state),
      page: page,
      isLoadMore: isLoadMore,
      cachedHiveModel: HiveDB.getTopHeadlines()?.toFreezedModel(),
      onModelUpdate: (model) => newsModel = model,
      onCacheSave: (model) => HiveDB.saveTopHeadlines(model.toHiveModel()),
      getCurrentModel: () => newsModel,
      apiCall:
          () => VPSDio.get(path: ApiConst.topHeadlines, queryParameters: query),
      mergeArticles: (fresh, combined) => fresh.copyWith(articles: combined),
      onSuccess: (news, page) => NewsHeadlinesStateSuccess(news, page),
      onError: (msg) => NewsHeadlinesStateError(msg),
      onBad: (e) => emit(NewsHeadlinesStateBad(e.toString())),
      onLoading: () => emit(NewsHeadlinesStateLoading()),
    );
  }
}
