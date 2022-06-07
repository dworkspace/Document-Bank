class VerifyEmailArg {
  final String email;
  final FromEmailVerifyEnum fromPage;
  VerifyEmailArg({
    required this.email,
    this.fromPage = FromEmailVerifyEnum.register,
  });
}

enum FromEmailVerifyEnum { register, forgotPassword }
