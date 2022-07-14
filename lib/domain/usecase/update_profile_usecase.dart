import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/profile_requests.dart';
import 'package:document_bank/domain/model/profile.dart';
import 'package:document_bank/domain/repository/profile_repository.dart';
import 'package:document_bank/domain/usecase/base_usecase.dart';
class UpdateProfileUseCase extends BaseUseCase<UpdateProfileRequest, Profile> {
  final ProfileRepository _profileRepository;

  UpdateProfileUseCase(this._profileRepository);

  @override
  Future<Either<CustomFailure, Profile>> execute(
      UpdateProfileRequest input) async {
    return await _profileRepository.updateProfile(input);
  }
}

