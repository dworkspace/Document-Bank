class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "password": password,
    };
  }
}

class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword
    };
  }
}

class OtpVerifyRequest {
  final String email;
  final String otp;
  final String endURL;
  OtpVerifyRequest({
    required this.email,
    required this.otp,
    this.endURL = "/activate-account",
  });

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "token": otp,
    };
  }
}

class ResetPasswordRequest {
  final String email;
  final String password;
  final String confirmPassword;
  final String token;
  ResetPasswordRequest({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword,
      "token": token
    };
  }
}
