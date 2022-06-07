part of 'otp_verify_cubit.dart';

abstract class OtpVerifyState extends Equatable {
  const OtpVerifyState();

  @override
  List<Object> get props => [];
}

class OtpVerifyInitial extends OtpVerifyState {}

class OtpVerifyLoading extends OtpVerifyState {}

class OtpVerifySuccess extends OtpVerifyState {
  final OtpVerifyResponse otpVerifyResponse;
  const OtpVerifySuccess({
    required this.otpVerifyResponse,
  });
}

class OtpVerifyFail extends OtpVerifyState {
  final String failMsg;
  const OtpVerifyFail({
    required this.failMsg,
  });
}
