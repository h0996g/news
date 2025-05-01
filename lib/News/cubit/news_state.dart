part of 'news_cubit.dart';

sealed class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

final class NewsInitial extends NewsState {}

final class NewsEverythingStateLoading extends NewsState {}

final class NewsEverythingStateSuccess extends NewsState {
  final NewsModel newsModel;

  const NewsEverythingStateSuccess(this.newsModel);
}

final class NewsEverythingStateError extends NewsState {
  final String error;

  const NewsEverythingStateError(this.error);
}

final class NewsEverythingStateBad extends NewsState {}

final class NewsHeadlinesStateLoading extends NewsState {}

final class NewsHeadlinesStateSuccess extends NewsState {
  final NewsModel newsModel;

  const NewsHeadlinesStateSuccess(this.newsModel);
}

final class NewsHeadlinesStateError extends NewsState {
  final String error;

  const NewsHeadlinesStateError(this.error);
}

final class NewsHeadlinesStateBad extends NewsState {}
