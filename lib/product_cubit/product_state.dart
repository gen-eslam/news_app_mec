part of 'product_cubit.dart';

abstract class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {
  final List<ProductModel> products;

  ProductSuccess({required this.products});
}

final class ProductError extends ProductState {
  final String errorMessage;
  ProductError({required this.errorMessage});
}

final class CategoryLoading extends ProductState {}

final class CategorySuccess extends ProductState {
  final List<String> categories;

  CategorySuccess({required this.categories});
}

final class CategoryError extends ProductState {
  final String errorMessage;
  CategoryError({required this.errorMessage});
}

class ProductCustomState extends ProductState {
  final ProductEnumState state;
  final List<ProductModel> products;
  final String errorMessage;

  ProductCustomState(
      {this.state = ProductEnumState.loading,
      this.products = const [],
      this.errorMessage = ""});

  ProductCustomState copyWith(
      {ProductEnumState? state,
      List<ProductModel>? products,
      String? errorMessage}) {
    return ProductCustomState(
      state: state ?? this.state,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

enum ProductEnumState { loading, success, error }

class ProductAddState extends ProductState {
  final ProductEnumState state;
  final ProductModel? products;
  final String errorMessage;

  ProductAddState(
      {this.state = ProductEnumState.loading,
      this.products ,
      this.errorMessage = ""});

  ProductAddState copyWith(
      {ProductEnumState? state,
      ProductModel? products,
      String? errorMessage}) {
    return ProductAddState(
      state: state ?? this.state,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
