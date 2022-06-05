part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheck extends AuthEvent {}

class LoggedIn extends AuthEvent {}

class LoggedOut extends AuthEvent {}
