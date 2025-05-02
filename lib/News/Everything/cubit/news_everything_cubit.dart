import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Model/news/news_model.dart';
import 'package:news/News/function.dart/get_news_f.dart';
import 'package:news/api/api_const.dart';
import 'package:news/api/dio.dart';
import 'package:news/const/const.dart';
import 'package:news/helper/hive/hive.dart';
import 'package:news/helper/hive/BD/news/news_model_mapper.dart';

part 'news_everything_state.dart';

class NewsEverythingCubit extends Cubit<NewsEverythingState> {
  NewsEverythingCubit() : super(NewsInitial());
  static NewsEverythingCubit get(context) => BlocProvider.of(context);
  NewsModel? newsModel;

  Future<void> getNewsEverything({
    String keyword = 'all',
    int page = 1,
    bool isLoadMore = false,
  }) async {
    final query = {
      'q': keyword,
      'from': defaultEverythingFilter?.from?.toIso8601String(),
      'to': defaultEverythingFilter?.to?.toIso8601String(),
      'page': page.toString(),
      'pageSize': pageSize,
      'sources': defaultEverythingFilter?.source,
    };

    await fetchNewsData<NewsEverythingState>(
      emitFunction: (state) => emit(state),
      page: page,
      isLoadMore: isLoadMore,
      cachedHiveModel: HiveDB.getEverything()?.toFreezedModel(),
      onModelUpdate: (model) => newsModel = model,
      onCacheSave: (model) => HiveDB.saveEverything(model.toHiveModel()),
      getCurrentModel: () => newsModel,
      apiCall:
          () => VPSDio.get(path: ApiConst.everything, queryParameters: query),
      mergeArticles: (fresh, combined) => fresh.copyWith(articles: combined),
      onSuccess: (news, page) => NewsEverythingStateSuccess(news, page),
      onError: (msg) => NewsEverythingStateError(msg),
      onBad: (e) {
        emit(NewsEverythingStateBad());
      },
      onLoading: () => emit(NewsEverythingStateLoading()),
    );
  }
}
