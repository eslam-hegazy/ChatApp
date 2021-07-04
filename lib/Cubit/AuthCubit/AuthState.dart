import 'package:chatapp/Model/AuthModel.dart';

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class VisiabilityState extends AuthState {}

class LoadingRegisterState extends AuthState {}

class SuccessfulRegisterState extends AuthState {
  final String token;

  SuccessfulRegisterState(this.token);
}

class ErrorRegisterState extends AuthState {
  final String error;

  ErrorRegisterState(this.error);
}

class LoadingLoginState extends AuthState {}

class SuccessfulLoginState extends AuthState {
  final String token;

  SuccessfulLoginState(this.token);
}

class ErrorLoginState extends AuthState {
  final String error;

  ErrorLoginState(this.error);
}
