import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/response/auth_reponses.dart';
import 'package:document_bank/domain/repository/auth_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class SendOtpForgotPasswordUseCase
    extends BaseUseCase<String, ForgotPasswordResponse> {
  final AuthRepository _authRepository;

  SendOtpForgotPasswordUseCase(this._authRepository);

  @override
  Future<Either<CustomFailure, ForgotPasswordResponse>> execute(
      String input) async {
    return await _authRepository.sendOtpForForgotPassword(input);
  }
}
