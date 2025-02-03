import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;

  LoginSuccess({required this.token});

  @override
  List<Object> get props => [token];
}

class LoginFailed extends LoginState {
  final String message;

  LoginFailed(this.message);

  @override
  List<Object> get props => [message];
}
