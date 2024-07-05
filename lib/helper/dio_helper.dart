import 'package:dio/dio.dart';
import 'package:flutter_application_1/helper/end_points.dart';

abstract class DioHelper {
  static final Dio _dio = Dio();

  static void init() {
    _dio.options.baseUrl = EndPoints.baseUrl;
  }

  static Future<Response> get({
    required String path,
    Map<String, dynamic>? query,
  }) async {
    return await _dio.get(
      path,
      queryParameters: query,
    );
  }
}
