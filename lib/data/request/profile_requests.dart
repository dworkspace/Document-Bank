class UpdateProfileRequest {
  final String name;
  final String username;
  final String country;
  final String dob;
  final String phone;
  final String? imagePath;

  UpdateProfileRequest({
    required this.name,
    required this.username,
    required this.country,
    required this.dob,
    required this.phone,
    this.imagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "username": username,
      "dob": dob,
      "country": country,
      "phone": phone,
    };
  }
}

class AccountSetupRequest {
  final String country;
  final String username;
  final String phone;
  final String dob;
  final String photoPath;

  AccountSetupRequest({
    required this.country,
    required this.username,
    required this.phone,
    required this.dob,
    required this.photoPath,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "country": country,
      "dob": dob,
      "phone": phone,
    };
  }
}

class ChangePasswordRequest {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "current_password": currentPassword,
      "password": newPassword,
      "password_confirmation": confirmPassword,
    };
  }
}
