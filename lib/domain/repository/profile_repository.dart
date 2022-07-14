import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/profile_requests.dart';
import 'package:document_bank/domain/model/profile.dart';

abstract class ProfileRepository {
  Future<Either<CustomFailure, Profile>> getProfile();
  Future<Either<CustomFailure, Profile>> updateProfile(UpdateProfileRequest updateProfileRequest);
}
