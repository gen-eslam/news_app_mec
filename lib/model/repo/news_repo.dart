import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/errors.dart';
import 'package:flutter_application_1/helper/dio_helper.dart';
import 'package:flutter_application_1/helper/end_points.dart';
import 'package:flutter_application_1/model/news_model.dart';

abstract class NewsRepo {
  Future<Either<Failures, NewsModel>> getNews();
}

class NewsRepoImpl extends NewsRepo {
  @override
  Future<Either<Failures, NewsModel>> getNews() async {
    try {
      // throw LocalFailures(errorMessage: "local error");
      Response response = await DioHelper.get(path: EndPoints.appleNews);
      return Right(NewsModel.fromJson(response.data));
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
