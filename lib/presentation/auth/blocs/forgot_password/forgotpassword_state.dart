part of 'forgotpassword_cubit.dart';

class ForgotpasswordState {
  final ForgotPasswordActionEnum? requestEmailStatus;
  final ForgotPasswordActionEnum? resetPasswordStatus;
  final ForgotPasswordResponse? sendOtpResponse;
  final ForgotPasswordResponse? verifyOtpResponse;
  final ForgotPasswordResponse? resetPasswordResponse;
  final String? errorMessage;

  ForgotpasswordState({
    this.requestEmailStatus = ForgotPasswordActionEnum.initial,
    this.resetPasswordStatus = ForgotPasswordActionEnum.initial,
    this.resetPasswordResponse,
    this.sendOtpResponse,
    this.verifyOtpResponse,
    this.errorMessage,
  });

  ForgotpasswordState copyWith({
    ForgotPasswordActionEnum? requestEmailStatus,
    ForgotPasswordActionEnum? resetPasswordStatus,
    ForgotPasswordResponse? sendOtpResponse,
    ForgotPasswordResponse? verifyOtpResponse,
    ForgotPasswordResponse? resetPasswordResponse,
    String? errorMessage,
  }) {
    return ForgotpasswordState(
      requestEmailStatus: requestEmailStatus,
      resetPasswordStatus: resetPasswordStatus,
      sendOtpResponse: sendOtpResponse,
      verifyOtpResponse: verifyOtpResponse,
      resetPasswordResponse: resetPasswordResponse,
      errorMessage: errorMessage,
    );
  }
}

enum ForgotPasswordActionEnum { initial, loading, success, failure }
