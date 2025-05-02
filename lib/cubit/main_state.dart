part of 'main_cubit.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}

final class NoConnection extends MainState {}

final class Connection extends MainState {}
