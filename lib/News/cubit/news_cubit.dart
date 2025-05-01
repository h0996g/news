import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Model/news_response.dart';
import 'package:news/api/api_const.dart';
import 'package:news/api/dio.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());
  static NewsCubit get(context) => BlocProvider.of(context);
  NewsModel? newsModel;
  Future<void> getNews() async {
    emit(NewsStateLoading());
    VPSDio.get(path: ApiConst.everything, queryParameters: {'q': 'tesla'})
        .then((value) {
          if (value.statusCode == 200) {
            newsModel = NewsModel.fromJson(value.data);
            emit(NewsStateSuccess(newsModel!));
          } else {
            print(value.data);
            emit(NewsStateError(value.statusMessage!));
          }
        })
        .catchError((e) {
          print(e);
          emit(NewsStateBad());
        });
  }
}
