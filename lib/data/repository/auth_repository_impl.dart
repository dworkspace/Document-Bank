import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/exceptions.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/network/network_info.dart';
import 'package:document_bank/data/request/auth_requests.dart';
import 'package:document_bank/data/response/auth_reponses.dart';
import 'package:document_bank/data/source/remote_source.dart';
import 'package:document_bank/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final NetworkInfo _networkInfo;
  final RemoteSource _remoteSource;

  AuthRepositoryImpl(this._networkInfo, this._remoteSource);

/*
 *USER LOGIN  
 */
  @override
  Future<Either<CustomFailure, LoginResponse>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected()) {
      try {
        final LoginResponse loginResponse =
            await _remoteSource.login(loginRequest);
        return Right(loginResponse);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  /*
   * USER REGISETER
   */

  @override
  Future<Either<CustomFailure, String>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected()) {
      try {
        final String registerSuccessMsg =
            await _remoteSource.register(registerRequest);
        return Right(registerSuccessMsg);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }

  /*
   * ACTIVATE ACCOUNT 
   */
  @override
  Future<Either<CustomFailure, String>> activateAccount(
      ActivateAccountRequest activateAccountRequest) async {
    if (await _networkInfo.isConnected()) {
      try {
        final String activateSuccessMsg =
            await _remoteSource.activateAccount(activateAccountRequest);
        return Right(activateSuccessMsg);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
