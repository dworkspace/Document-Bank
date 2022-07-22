import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/profile_requests.dart';
import 'package:document_bank/domain/model/account_setup.dart';
import 'package:document_bank/domain/repository/auth_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class AccountSetupUseCase
    extends BaseUseCase<AccountSetupRequest, AccountSetup> {
  final AuthRepository _authRepository;

  AccountSetupUseCase(this._authRepository);

  @override
  Future<Either<CustomFailure, AccountSetup>> execute(
      AccountSetupRequest input) async {
    return await _authRepository.accountSetup(input);
  }
}
