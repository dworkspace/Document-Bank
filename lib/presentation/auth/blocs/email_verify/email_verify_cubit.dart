import 'package:bloc/bloc.dart';
import 'package:document_bank/data/request/auth_requests.dart';
import 'package:document_bank/domain/usecase/activate_account_usecase.dart';
import 'package:equatable/equatable.dart';

part 'email_verify_state.dart';

class EmailVerifyCubit extends Cubit<EmailVerifyState> {
  EmailVerifyCubit(this._activateAccountUseCase) : super(EmailVerifyInitial());

  void activateAccount(String pin, String email) async {
    emit(EmailVerifyLoading());
    final ActivateAccountRequest request = ActivateAccountRequest(
      email: email,
      otp: pin,
    );
    final response = await _activateAccountUseCase.execute(request);
    response.fold(
      (fail) => emit(EmailVerifyFailure(failMsg: fail.message)),
      (success) => emit(EmailVerifySuccess(successMsg: success)),
    );
  }

  final ActivateAccountUseCase _activateAccountUseCase;
}
