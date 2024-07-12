import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  int id;
  String title;
  num price;
  String description;
  String category;
  String image;
  Rating rating;
  ProductModel(
      {required this.id,
      required this.category,
      required this.price,
      required this.description,
      required this.image,
      required this.title,
      required this.rating});
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        category: json["category"],
        price: json["price"],
        description: json["description"],
        image: json["image"],
        title: json["title"],
        rating: Rating.fromJson(
          json["rating"],
        ),
      );
  @override
  List<Object?> get props => [id, title, price, description, category, image];
}

class Rating extends Equatable {
  num? rate, count;
  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"],
        count: json["count"],
      );

  @override
  List<Object?> get props => [rate, count];
}
