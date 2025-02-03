import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_task_management/domain/repositories/login/login_repository.dart';
import 'package:flutter_crud_task_management/presentation/bloc/login/login_event.dart';
import 'package:flutter_crud_task_management/presentation/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc(this.repository) : super(LoginInitial()) {
    on<LoginRequest>(
      (event, emit) async {
        emit(LoginLoading());
        try {
          final response =
              await repository.requestLogin(event.username, event.password);
          if (response.token != null) {
            emit(LoginSuccess(token: response.token ?? ''));
          } else {
            emit(LoginFailed('Login failed cause invalid token'));
          }
        } catch (e) {
          emit(LoginFailed(e.toString()));
        }
      },
    );
  }
}
