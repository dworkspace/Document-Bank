class User {
  final int id;
  final String name;
  final String email;
  final String token;
  final String profilePhotoURL;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    required this.profilePhotoURL,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
      profilePhotoURL: map['profile_photo_url'] ?? '',
    );
  }
}
