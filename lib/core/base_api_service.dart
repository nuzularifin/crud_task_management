import 'package:dio/dio.dart';
import 'package:flutter_crud_task_management/utils/logging_interceptor.dart';

class BaseApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://reqres.in/api/';

  BaseApiService() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(LoggingInterceptor());
  }

  Dio get dio => _dio;
  String get baseUrl => _baseUrl;
}
