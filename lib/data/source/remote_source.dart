import 'package:dio/dio.dart';
import 'package:document_bank/core/utils/exceptions.dart';
import 'package:document_bank/data/request/auth_requests.dart';
import 'package:document_bank/data/response/auth_reponses.dart';

abstract class RemoteSource {
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future<String> register(RegisterRequest registerRequest);
  Future<String> activateAccount(ActivateAccountRequest activateAccountRequest);
  Future<String> forgotPassword(String email);
  Future<String> verifyOtpForForgotPassword(
      ActivateAccountRequest verifyOtpRequest);
  
}

class RemoteSourceImpl implements RemoteSource {
  final Dio dio;

  RemoteSourceImpl(this.dio);

  /*
   * USER LOGIN 
   */
  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      final loginResponse = await dio.post(
        "/login",
        data: loginRequest.toMap(),
      );
      final mapBody = loginResponse.data;
      return LoginResponse.fromLoginResponse(mapBody);
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  /*
   * USER REGISTER 
   */
  @override
  Future<String> register(RegisterRequest registerRequest) async {
    try {
      final loginResponse = await dio.post(
        "/register-user",
        data: registerRequest.toMap(),
      );
      final mapBody = loginResponse.data;
      return mapBody['message'];
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

/*
 * ACTIVATE ACCOUNT 
 */
  @override
  Future<String> activateAccount(
      ActivateAccountRequest activateAccountRequest) async {
    try {
      final loginResponse = await dio.post(
        "/activate-account",
        data: activateAccountRequest.toMap(),
      );
      final mapBody = loginResponse.data;
      return mapBody['message'];
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

/*
 * FORGOT PASSWORD
 */
  @override
  Future<String> forgotPassword(String email) async {
    try {
      final loginResponse = await dio.post(
        "/forget-password",
        data: {"email": email},
      );
      final mapBody = loginResponse.data;
      return mapBody['message'];
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  /*
   * VERIFY OTP FOR FORGOT PASSWORD 
   */
  @override
  Future<String> verifyOtpForForgotPassword(
      ActivateAccountRequest verifyOtpRequest) async {
    try {
      final loginResponse = await dio.post(
        "/forget-password-verify-otp",
        data: verifyOtpRequest.toMap(),
      );
      final mapBody = loginResponse.data;
      return mapBody['message'];
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
