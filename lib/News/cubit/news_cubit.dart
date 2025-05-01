import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Model/news/news_response.dart';
import 'package:news/api/api_const.dart';
import 'package:news/api/dio.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());
  static NewsCubit get(context) => BlocProvider.of(context);
  NewsModel? newsEverythingModel;
  Future<void> getNewsEverything({
    String? fromDate,
    String? toDate,
    String? source,
    String keyword = 'latest',
  }) async {
    emit(NewsEverythingStateLoading());
    try {
      final Map<String, dynamic> query = {
        'q': keyword,
        'from': fromDate,
        'to': toDate,
        if (source != null && source.isNotEmpty) 'sources': source,
      };

      final value = await VPSDio.get(
        path: ApiConst.everything,
        queryParameters: query,
      );

      if (value.statusCode == 200) {
        newsEverythingModel = NewsModel.fromJson(value.data);
        emit(NewsEverythingStateSuccess(newsEverythingModel!));
      } else {
        print(value.data);
        emit(NewsEverythingStateError(value.statusMessage ?? 'Unknown error'));
      }
    } catch (e) {
      print(e);
      emit(NewsEverythingStateBad());
    }
  }
}
