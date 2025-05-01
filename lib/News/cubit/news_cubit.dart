import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Model/news_response.dart';
import 'package:news/api/api_const.dart';
import 'package:news/api/dio.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());
  static NewsCubit get(context) => BlocProvider.of(context);
  NewsModel? newsEverythingModel;
  Future<void> getNewsEverything({
    Map<String, dynamic>? queryParameters,
  }) async {
    emit(NewsEverythingStateLoading());
    try {
      final value = await VPSDio.get(
        path: ApiConst.everything,
        queryParameters: queryParameters ?? {'q': 'latest'},
      );
      if (value.statusCode == 200) {
        newsEverythingModel = NewsModel.fromJson(value.data);
        emit(NewsEverythingStateSuccess(newsEverythingModel!));
      } else {
        emit(NewsEverythingStateError(value.statusMessage ?? 'Unknown error'));
      }
    } catch (e) {
      print(e);
      emit(NewsEverythingStateBad());
    }
  }

  NewsModel? newsHeadlinesModel;

  Future<void> getNewsHeadlines() async {
    emit(NewsEverythingStateLoading());
    VPSDio.get(path: ApiConst.topHeadlines, queryParameters: {'country': 'us'})
        .then((value) {
          if (value.statusCode == 200) {
            newsHeadlinesModel = NewsModel.fromJson(value.data);
            emit(NewsEverythingStateSuccess(newsHeadlinesModel!));
          } else {
            print(value.data);
            emit(NewsEverythingStateError(value.statusMessage!));
          }
        })
        .catchError((e) {
          print(e);
          emit(NewsEverythingStateBad());
        });
  }
}
