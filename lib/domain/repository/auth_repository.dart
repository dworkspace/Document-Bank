import 'package:dartz/dartz.dart';
import 'package:document_bank/core/utils/failure.dart';
import 'package:document_bank/data/request/auth_requests.dart';
import 'package:document_bank/data/request/profile_requests.dart';
import 'package:document_bank/data/response/auth_reponses.dart';
import 'package:document_bank/domain/model/account_setup.dart';

abstract class AuthRepository {
  Future<Either<CustomFailure, LoginResponse>> login(LoginRequest loginRequest);

  Future<Either<CustomFailure, String>> register(
      RegisterRequest registerRequest);

  Future<Either<CustomFailure, AccountSetup>> accountSetup(
      AccountSetupRequest accountSetupRequest);

  Future<Either<CustomFailure, OtpVerifyResponse>> verifyOtp(
      OtpVerifyRequest activateAccountRequest);

  Future<Either<CustomFailure, ForgotPasswordResponse>>
      sendOtpForForgotPassword(String email);

  Future<Either<CustomFailure, String>> resetForgotPassword(
      ResetPasswordRequest resetPasswordRequest);
}
