import 'package:dio/dio.dart';
import 'package:flutter_crud_task_management/core/base_api_service.dart';
import 'package:flutter_crud_task_management/data/model/response/login_response_model.dart';

class RemoteLoginDataSource extends BaseApiService {
  Future<LoginResponseModel> requestLogin(
    String username,
    String password,
  ) async {
    try {
      final response = await dio.post('/login', data: {
        'email': username,
        'password': password,
      });
      if (response.statusCode == 200) {
        final result = LoginResponseModel(token: response.data['token']);
        return result;
      } else {
        throw Exception('Login Failed with status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(
          'Failed login cause : ${e.response?.statusCode} ${e.response?.data['error']}');
    }
  }
}
