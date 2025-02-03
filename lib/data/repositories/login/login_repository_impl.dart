import 'package:flutter_crud_task_management/data/datasources/login/remote_login_data_source.dart';
import 'package:flutter_crud_task_management/data/model/response/login_response_model.dart';
import 'package:flutter_crud_task_management/domain/repositories/login/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final RemoteLoginDataSource remoteLoginDataSource;

  LoginRepositoryImpl({required this.remoteLoginDataSource});

  @override
  Future<LoginResponseModel> requestLogin(String username, String password) {
    return remoteLoginDataSource.requestLogin(username, password);
  }
}
