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
  }) async {
    emit(NewsEverythingStateLoading());

    // Step 1: Load from cache immediately if available
    final cached = HiveDB.getNews();
    if (cached != null) {
      emit(NewsEverythingStateSuccess(cached.toFreezedModel()));
    }

    // Step 2: Build query
    final query = {
      'q': keyword,
      'from': fromDate,
      'to': toDate,
      if (source != null && source.isNotEmpty) 'sources': source,
    };

    // Step 3: Fetch fresh data using .then()
    VPSDio.get(path: ApiConst.everything, queryParameters: query)
        .then((value) {
          if (value.statusCode == 200) {
            final freshNews = NewsModel.fromJson(value.data);

            // Save to Hive
            HiveDB.saveNews(freshNews.toHiveModel()).then((_) {
              emit(NewsEverythingStateSuccess(freshNews));
            });
          } else {
            print('API Error: ${value.data}');
            if (cached == null) {
              emit(
                NewsEverythingStateError(
                  value.statusMessage ?? 'Unknown error',
                ),
              );
            }
          }
        })
        .catchError((error) {
          print('Fetch Error: $error');
          if (cached == null) {
            emit(NewsEverythingStateBad());
          }
        });
  }
}
