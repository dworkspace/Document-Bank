import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/auth_requests.dart';
import 'package:document_bank/data/response/auth_reponses.dart';
import 'package:document_bank/domain/repository/auth_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class LoginUseCase extends BaseUseCase<LoginRequest, LoginResponse> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<Either<CustomFailure, LoginResponse>> execute(
      LoginRequest input) async {
    return await _authRepository.login(input);
  }
}
