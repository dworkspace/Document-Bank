class LoginResponse {
  final String message;
  final String accessToken;
  final String tokenType;

  LoginResponse({
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });

  factory LoginResponse.fromLoginResponse(Map<String, dynamic> map) {
    return LoginResponse(
      message: map['message'],
      accessToken: map["access_token"],
      tokenType: map["token_type"],
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
