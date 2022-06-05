part of 'email_verify_cubit.dart';

abstract class EmailVerifyState extends Equatable {
  const EmailVerifyState();

  @override
  List<Object> get props => [];
}

class EmailVerifyInitial extends EmailVerifyState {}

class EmailVerifyLoading extends EmailVerifyState {}

class EmailVerifySuccess extends EmailVerifyState {
  final String successMsg;
  const EmailVerifySuccess({
    required this.successMsg,
  });
}

class EmailVerifyFailure extends EmailVerifyState {
  final String failMsg;
  const EmailVerifyFailure({
    required this.failMsg,
  });
}
