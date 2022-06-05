import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/auth_requests.dart';
import 'package:document_bank/domain/repository/auth_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class RegisterUseCase extends BaseUseCase<RegisterRequest, String> {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);
  @override
  Future<Either<CustomFailure, String>> execute(RegisterRequest input) async {
    return await _authRepository.register(input);
  }
}
