import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/errors.dart';
import 'package:flutter_application_1/helper/dio_helper.dart';
import 'package:flutter_application_1/helper/end_points.dart';
import 'package:flutter_application_1/model/news/news_model.dart';
import 'package:flutter_application_1/model/store/product_model.dart';

abstract class ProductRepo {
  Future<Either<Failures, List<ProductModel>>> getProducts();
  Future<Either<Failures, List<ProductModel>>> getSpecificProducts(
    String category,
  );

  Future<Either<Failures, List<String>>> getCategories();

  Future<Either<Failures, ProductModel>> addProduct(
    Map<String, dynamic> data,
  );
}

class ProductRepoImpl implements ProductRepo {
  @override
  Future<Either<Failures, List<ProductModel>>> getProducts() async {
    try {
      Response response = await DioHelper.get(path: StoreEndPoint.products);
      return Right(
        (response.data as List).map((e) => ProductModel.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(
        LocalFailures(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, List<String>>> getCategories() async {
    try {
      Response response = await DioHelper.get(path: StoreEndPoint.categories);
      return Right(
        (response.data as List).map((e) => e.toString()).toList(),
      );
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(
        LocalFailures(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, List<ProductModel>>> getSpecificProducts(
      String category) async {
    try {
      Response response = await DioHelper.get(
        path: StoreEndPoint.productsInASpecificCategory(
          category: category,
        ),
      );
      return Right(
        (response.data as List).map((e) => ProductModel.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(
        LocalFailures(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, ProductModel>> addProduct(
      Map<String, dynamic> data) async {
    try {
      Response response = await DioHelper.post(
        path: StoreEndPoint.products,
        data: data,
      );
      print(response.data);
      return Right(
        (ProductModel.fromJson(response.data)),
      );
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(
        LocalFailures(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
