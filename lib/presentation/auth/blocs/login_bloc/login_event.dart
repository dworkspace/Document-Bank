part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PerformLoginEvent extends LoginEvent {
  final LoginRequest loginRequest;

  const PerformLoginEvent(this.loginRequest);
}
