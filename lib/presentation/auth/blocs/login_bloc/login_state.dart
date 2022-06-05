part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponse loginResponse;

  const LoginSuccess(this.loginResponse);
}

class LoginFailure extends LoginState {
  final String errorMsg;

  const LoginFailure(this.errorMsg);
}
