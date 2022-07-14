import 'package:dio/dio.dart';
import 'package:document_bank/core/utils/constants.dart';

import '../../core/di /app_module.dart';
import '../../core/utils/app_prefs.dart';
import 'api_interceptor.dart';

class ApiClient {
  final dio = createDio();

  ApiClient._internal();

  static final _singleton = ApiClient._internal();

  factory ApiClient() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: AppConstants.apiBaseURL,
      receiveTimeout: 30000, // 15 seconds
      connectTimeout: 30000,
      sendTimeout: 30000,
    ));
    dio.interceptors.addAll(
      {
        AppInterceptors(dio: dio),
      },
    );
    return dio;
  }
}
