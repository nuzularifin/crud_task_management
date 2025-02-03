import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class LoginRequest extends LoginEvent {
  final String username;
  final String password;

  LoginRequest({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}
