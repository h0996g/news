part of 'news_headlines_cubit.dart';

sealed class NewsHeadlinesState extends Equatable {
  const NewsHeadlinesState();

  @override
  List<Object> get props => [];
}

final class NewsInitial extends NewsHeadlinesState {}

final class NewsHeadlinesStateLoading extends NewsHeadlinesState {}

final class NewsHeadlinesStateSuccess extends NewsHeadlinesState {
  final NewsModel newsModel;
  final int page;

  const NewsHeadlinesStateSuccess(this.newsModel, this.page);

  @override
  List<Object> get props => [newsModel, page];
  @override
  String toString() => 'NewsHeadlinesStateSuccess(page: $page, )';
}

final class NewsHeadlinesStateError extends NewsHeadlinesState {
  final String error;

  const NewsHeadlinesStateError(this.error);
}

final class NewsHeadlinesStateBad extends NewsHeadlinesState {
  final String error;
  const NewsHeadlinesStateBad(this.error);
}
