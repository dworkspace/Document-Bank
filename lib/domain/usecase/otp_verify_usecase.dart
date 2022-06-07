import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/auth_requests.dart';
import 'package:document_bank/data/response/auth_reponses.dart';
import 'package:document_bank/domain/repository/auth_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class OtpVerifyUseCase
    extends BaseUseCase<OtpVerifyRequest, OtpVerifyResponse> {
  final AuthRepository _authRepository;

  OtpVerifyUseCase(this._authRepository);
  @override
  Future<Either<CustomFailure, OtpVerifyResponse>> execute(
      OtpVerifyRequest input) async {
    return await _authRepository.verifyOtp(input);
  }
}
