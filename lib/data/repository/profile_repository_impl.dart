import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/profile_requests.dart';
import 'package:document_bank/data/response/profile_responses.dart';
import 'package:document_bank/domain/model/profile.dart';
import 'package:document_bank/domain/repository/profile_repository.dart';

import '../../core/utils/exceptions.dart';
import '../network/network_info.dart';
import '../source/remote_source.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final NetworkInfo _networkInfo;
  final RemoteSource _remoteSource;

  ProfileRepositoryImpl(this._remoteSource, this._networkInfo);

  @override
  Future<Either<CustomFailure, Profile>> getProfile() async {
    if (await _networkInfo.isConnected()) {
      try {
        final ProfileResponse response = await _remoteSource.getProfile();
        final Profile profile = Profile.fromProfileResponse(response);
        return Right(profile);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<CustomFailure, Profile>> updateProfile(
      UpdateProfileRequest updateProfileRequest) async {
    if (await _networkInfo.isConnected()) {
      try {
        final ProfileResponse response =
            await _remoteSource.updateProfile(updateProfileRequest);
        final Profile profile = Profile.fromProfileResponse(response);
        return Right(profile);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<CustomFailure, String>> changePassword(
      ChangePasswordRequest changePasswordRequest) async {
    if (await _networkInfo.isConnected()) {
      try {
        final String response =
            await _remoteSource.changePassword(changePasswordRequest);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
