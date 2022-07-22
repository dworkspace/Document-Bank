import 'package:document_bank/core/utils/enum.dart';
import 'package:document_bank/domain/model/user.dart';

class LoginResponse {
  final VerificationStatus verificationStatus;
  final String message;
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final User user;

  LoginResponse({
    required this.verificationStatus,
    required this.message,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  factory LoginResponse.fromLoginResponse(Map<String, dynamic> map) {
    return LoginResponse(
      verificationStatus: map['status'].toString().getVerificationStatusEnum(),
      message: map['message']??"",
      accessToken: map["access_token"] ?? "",
      tokenType: map["token_type"] ?? "",
      expiresIn: map["expires_in"]?.toInt() ?? 0,
      user: User.fromMap(map['user']),
    );
  }
}

class ForgotPasswordResponse {
  final String email;
  final String message;
  final String? token;

  ForgotPasswordResponse({
    required this.email,
    required this.message,
    this.token,
  });

  factory ForgotPasswordResponse.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordResponse(
      email: map['email'],
      message: map['message'],
      token: map['token'].toString(),
    );
  }
}

class OtpVerifyResponse {
  final String email;
  final String message;
  final String? token;

  OtpVerifyResponse({
    required this.email,
    required this.message,
    this.token,
  });

  factory OtpVerifyResponse.fromMap(Map<String, dynamic> map) {
    return OtpVerifyResponse(
      email: map['email'],
      message: map['message'],
      token: map['token'].toString(),
    );
  }
}
