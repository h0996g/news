part of 'news_everything_cubit.dart';

sealed class NewsEverythingState extends Equatable {
  const NewsEverythingState();

  @override
  List<Object> get props => [];
}

final class NewsInitial extends NewsEverythingState {}

final class NewsEverythingStateLoading extends NewsEverythingState {}

final class NewsEverythingStateSuccess extends NewsEverythingState {
  final NewsModel newsModel;
  final int page;

  const NewsEverythingStateSuccess(this.newsModel, this.page);

  @override
  List<Object> get props => [newsModel, page];
  @override
  String toString() => 'NewsEverythingStateSuccess(page: $page, )';
}

final class NewsEverythingStateError extends NewsEverythingState {
  final String error;

  const NewsEverythingStateError(this.error);
}

final class NewsEverythingStateBad extends NewsEverythingState {}

final class NewsHeadlinesStateLoading extends NewsEverythingState {}

final class NewsHeadlinesStateSuccess extends NewsEverythingState {
  final NewsModel newsModel;

  const NewsHeadlinesStateSuccess(this.newsModel);
}

final class NewsHeadlinesStateError extends NewsEverythingState {
  final String error;

  const NewsHeadlinesStateError(this.error);
}

final class NewsHeadlinesStateBad extends NewsEverythingState {}
