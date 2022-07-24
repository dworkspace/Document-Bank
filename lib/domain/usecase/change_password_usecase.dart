import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/profile_requests.dart';
import 'package:document_bank/domain/repository/profile_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class ChangePasswordUseCase extends BaseUseCase<ChangePasswordRequest, String> {
  final ProfileRepository _profileRepository;

  ChangePasswordUseCase(this._profileRepository);

  @override
  Future<Either<CustomFailure, String>> execute(
      ChangePasswordRequest input) async {
    return await _profileRepository.changePassword(input);
  }
}
