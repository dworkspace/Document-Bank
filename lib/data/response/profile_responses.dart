class ProfileResponse {
  final int id;
  final String name;
  final String email;
  final String username;
  final String country;
  final String phone;
  final String profileURL;
  final String dob;

  ProfileResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.country,
    required this.dob,
    required this.phone,
    required this.profileURL,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      id: json['id'] ?? -1,
      name: json['name'] ?? "N/A",
      email: json["email"] ?? "N/A",
      username: json["username"] ?? "N/A",
      country: json["country"] ?? "N/A",
      dob: json["dob"] ?? "N/A",
      phone: json['phone'] ?? "N/A",
      profileURL: json['photo'] ?? "",
    );
  }
}

class AccountSetupResponse {
  final String status;
  final String message;
  final ProfileResponse profileResponse;

  AccountSetupResponse({
    required this.status,
    required this.message,
    required this.profileResponse,
  });

  factory AccountSetupResponse.fromJson(Map<String, dynamic> json) {
    return AccountSetupResponse(
      status: json['status'],
      message: json['message'],
      profileResponse: ProfileResponse.fromJson(json['data']),
    );
  }
}
