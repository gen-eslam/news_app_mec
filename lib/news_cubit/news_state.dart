part of 'news_cubit.dart';

abstract class NewsState {}

final class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsSuccess extends NewsState {
  final List<Articles> articles;

  NewsSuccess({required this.articles});
}

class NewsError extends NewsState {
  final String error;
  NewsError({required this.error});
}
