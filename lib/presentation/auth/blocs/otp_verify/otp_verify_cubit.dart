import 'package:bloc/bloc.dart';
import 'package:document_bank/data/request/auth_requests.dart';
import 'package:document_bank/data/response/auth_reponses.dart';
import 'package:document_bank/domain/usecase/otp_verify_usecase.dart';
import 'package:equatable/equatable.dart';

part 'otp_verify_state.dart';

class OtpVerifyCubit extends Cubit<OtpVerifyState> {
  OtpVerifyCubit(this._activateAccountUseCase) : super(OtpVerifyInitial());

  void verifyOtp(String pin, String email, String endURL) async {
    emit(OtpVerifyLoading());
    final OtpVerifyRequest request = OtpVerifyRequest(
      email: email,
      otp: pin,
      endURL: endURL,
    );
    final response = await _activateAccountUseCase.execute(request);
    response.fold(
      (fail) => emit(OtpVerifyFail(failMsg: fail.message)),
      (success) => emit(OtpVerifySuccess(otpVerifyResponse: success)),
    );
  }

  final OtpVerifyUseCase _activateAccountUseCase;
}
