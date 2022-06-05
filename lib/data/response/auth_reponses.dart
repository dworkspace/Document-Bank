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
