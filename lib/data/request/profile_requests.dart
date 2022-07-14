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
