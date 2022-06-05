import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/auth_requests.dart';
import 'package:document_bank/domain/repository/auth_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class ActivateAccountUseCase
    extends BaseUseCase<ActivateAccountRequest, String> {
  final AuthRepository _authRepository;

  ActivateAccountUseCase(this._authRepository);
  @override
  Future<Either<CustomFailure, String>> execute(
      ActivateAccountRequest input) async {
    return await _authRepository.activateAccount(input);
  }
}
