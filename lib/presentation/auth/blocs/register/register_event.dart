part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class PerformRegisterEvent extends RegisterEvent {
  final RegisterRequest registerRequest;
  const PerformRegisterEvent({
    required this.registerRequest,
  });
}
