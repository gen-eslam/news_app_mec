import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/model/articales_model.dart';
import 'package:flutter_application_1/model/repo/news_repo.dart';
import 'package:meta/meta.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit({required this.newsRepo}) : super(NewsInitial());

  NewsRepo newsRepo;

  void getNews() async {
    emit(NewsLoading());
    final res = await newsRepo.getNews();
    res.fold((error) {
      emit(NewsError(error: error.errorMessage));
    }, (data) {
      emit(NewsSuccess(articles: data.articles));
    });
  }
}
