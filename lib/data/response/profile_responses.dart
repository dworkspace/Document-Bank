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
