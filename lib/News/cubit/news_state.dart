part of 'news_cubit.dart';

sealed class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

final class NewsInitial extends NewsState {}

final class NewsStateLoading extends NewsState {}

final class NewsStateSuccess extends NewsState {
  final NewsModel newsModel;

  const NewsStateSuccess(this.newsModel);
}

final class NewsStateError extends NewsState {
  final String error;

  const NewsStateError(this.error);
}

final class NewsStateBad extends NewsState {}
