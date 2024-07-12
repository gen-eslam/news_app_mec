import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/errors.dart';
import 'package:flutter_application_1/helper/dio_helper.dart';
import 'package:flutter_application_1/helper/end_points.dart';
import 'package:flutter_application_1/model/news/news_model.dart';
import 'package:flutter_application_1/model/store/product_model.dart';

abstract class ProductRepo {
  Future<Either<Failures, List<ProductModel>>> getProducts();
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
}
