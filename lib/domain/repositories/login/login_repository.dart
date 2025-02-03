import 'package:flutter_crud_task_management/data/model/response/login_response_model.dart';

abstract class LoginRepository {
  Future<LoginResponseModel> requestLogin(String username, String password);
}
