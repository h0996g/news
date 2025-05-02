import 'package:dio/dio.dart';

import 'package:news/Model/news/news_model.dart';

/// Generic helper function to fetch paginated news data from an API and emit bloc states.
///
/// This function handles:
/// - Showing loading indicators only when `isLoadMore` is false
/// - Returning cached data for page 1 (if available)
/// - Making a Dio GET request
/// - Saving fresh data to cache on page 1
/// - Appending articles when loading more pages
/// - Emitting appropriate success, error, or fallback states
///
/// Parameters:
/// - [emitFunction]: Emits state back to the cubit
/// - [page]: Page number to fetch (1 = first load)
/// - [isLoadMore]: If true, this is a paginated request (no loading spinner emitted)
/// - [cachedHiveModel]: Cached data for page 1 (can be null)
/// - [onModelUpdate]: Updates the cubit's internal NewsModel
/// - [onCacheSave]: Caches the fresh news data
/// - [getCurrentModel]: Retrieves the latest NewsModel
/// - [apiCall]: Async Dio GET request to fetch data
/// - [mergeArticles]: Combines old and new articles
/// - [onSuccess]: Builds the success state with data
/// - [onError]: Builds an error state with a message
/// - [onBad]: Called on first-page network failure
/// - [onLoading]: (Optional) Emits loading state for non-paginated calls
Future<void> fetchNewsData<T>({
  required void Function(T state) emitFunction,
  required int page,
  required bool isLoadMore,
  required NewsModel? cachedHiveModel,
  required void Function(NewsModel) onModelUpdate,
  required void Function(NewsModel) onCacheSave,
  required NewsModel? Function() getCurrentModel,
  required Future<Response> Function() apiCall,
  required NewsModel Function(NewsModel fresh, List<ArticleModel> combined)
  mergeArticles,
  required T Function(NewsModel newsModel, int page) onSuccess,
  required T Function(String message) onError,
  required void Function(String e) onBad,
  void Function()? onLoading,
}) async {
  if (!isLoadMore && onLoading != null) {
    onLoading();
  }

  if (page == 1 && cachedHiveModel != null) {
    onModelUpdate(cachedHiveModel);
    emitFunction(onSuccess(cachedHiveModel, page));
  }

  try {
    final response = await apiCall();

    if (response.statusCode == 200) {
      final freshNews = NewsModel.fromJson(response.data);

      if (page == 1) {
        onCacheSave(freshNews);
        onModelUpdate(freshNews);
        emitFunction(onSuccess(freshNews, page));
      } else {
        final current = getCurrentModel();

        if ((freshNews.articles?.isEmpty ?? true)) {
          emitFunction(onError("No more articles available."));
          return;
        }

        final combined = [...?current?.articles, ...?freshNews.articles];

        final mergedNews = mergeArticles(freshNews, combined);
        onModelUpdate(mergedNews);
        emitFunction(onSuccess(mergedNews, page));
      }
    } else {
      emitFunction(onError(response.data['message'] ?? 'Unknown error'));
    }
  } catch (e) {
    if (page == 1) onBad(e.toString());
  }
}
