import 'package:document_bank/data/response/profile_responses.dart';

class Profile {
  final int id;
  final String name;
  final String email;
  final String username;
  final String country;
  final String phone;
  final String profileURL;
  final String dob;

  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.country,
    required this.dob,
    required this.phone,
    required this.profileURL,
  });

  factory Profile.fromProfileResponse(ProfileResponse response) {
    return Profile(
      id: response.id,
      name: response.name,
      email: response.email,
      username: response.username,
      country: response.username,
      dob: response.dob,
      phone: response.phone,
      profileURL: response.profileURL,
    );
  }
}
