import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/model/news/articales_model.dart';

class NewsModel extends Equatable {
  final String status;
  int totalResults;
  final List<Articles> articles;

  NewsModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      status: json['status']??"",
      totalResults: json['totalResults']?? 0,
      articles: List<Articles>.from(
        json["articles"].map((x) => Articles.fromJson(x)) ?? [],
      ),
    );
  }

  @override
  List<Object?> get props => [status, totalResults, articles];
}


