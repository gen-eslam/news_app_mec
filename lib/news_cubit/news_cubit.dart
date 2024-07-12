import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/news/articales_model.dart';
import 'package:flutter_application_1/model/news/repo/news_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit({required this.newsRepo}) : super(NewsInitial());
  static NewsCubit get(BuildContext context) =>
      BlocProvider.of<NewsCubit>(context);

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
