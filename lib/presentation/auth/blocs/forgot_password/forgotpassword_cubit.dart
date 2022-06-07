import 'package:bloc/bloc.dart';
import 'package:document_bank/data/request/auth_requests.dart';
import 'package:document_bank/domain/usecase/reset_forgot_password_use_case.dart';
import 'package:document_bank/domain/usecase/send_otp_forgot_password_usecase.dart';

import '../../../../data/response/auth_reponses.dart';

part 'forgotpassword_state.dart';

class ForgotpasswordCubit extends Cubit<ForgotpasswordState> {
  ForgotpasswordCubit(
    this._sendOtpForgotPasswordUseCase,
    this._resetForgotPasswordUseCase,
  ) : super(ForgotpasswordState());

  void sendOtp(String email) async {
    emit(state.copyWith(requestEmailStatus: ForgotPasswordActionEnum.loading));
    final response = await _sendOtpForgotPasswordUseCase.execute(email);
    response.fold(
      (fail) => emit(state.copyWith(
        requestEmailStatus: ForgotPasswordActionEnum.failure,
        errorMessage: fail.message,
      )),
      (success) => emit(state.copyWith(
        requestEmailStatus: ForgotPasswordActionEnum.success,
        sendOtpResponse: success,
      )),
    );
  }

  void resetPassword(ResetPasswordRequest resetPasswordRequest) async {
    emit(state.copyWith(resetPasswordStatus: ForgotPasswordActionEnum.loading));
    final response =
        await _resetForgotPasswordUseCase.execute(resetPasswordRequest);
    response.fold(
      (fail) => emit(state.copyWith(
        resetPasswordStatus: ForgotPasswordActionEnum.failure,
        errorMessage: fail.message,
      )),
      (success) => emit(state.copyWith(
        resetPasswordStatus: ForgotPasswordActionEnum.success,
        resetPasswordResponse: success,
      )),
    );
  }

  final SendOtpForgotPasswordUseCase _sendOtpForgotPasswordUseCase;
  final ResetForgotPasswordUseCase _resetForgotPasswordUseCase;
}
