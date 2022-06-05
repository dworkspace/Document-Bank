part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String successMsg;
  const RegisterSuccess({
    required this.successMsg,
  });
}

class RegisterFailure extends RegisterState {
  final String errorMessage;
  const RegisterFailure({
    required this.errorMessage,
  });
}
