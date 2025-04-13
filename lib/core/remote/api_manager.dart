
import 'package:azkar_app/core/resources/constants_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
@injectable
class ApiManager {
  Dio dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl))..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      enabled: kDebugMode,
    ));

  Future<Response> getRequest(String path,
    Map<String, dynamic>? queryParameters,
  ) {
    return dio.get(path, queryParameters: queryParameters);
  }
}
