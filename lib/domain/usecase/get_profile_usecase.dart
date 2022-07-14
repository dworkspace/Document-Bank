import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/domain/model/profile.dart';
import 'package:document_bank/domain/repository/profile_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';

class GetProfileUseCase extends BaseUseCase<void, Profile> {
  final ProfileRepository _profileRepository;

  GetProfileUseCase(this._profileRepository);

  @override
  Future<Either<CustomFailure, Profile>> execute(void input) async {
    return await _profileRepository.getProfile();
  }
}
