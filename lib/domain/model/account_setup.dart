import 'package:document_bank/data/response/profile_responses.dart';
import 'package:document_bank/domain/model/profile.dart';

class AccountSetup {
  final String status;
  final String message;
  final Profile profile;

  AccountSetup({
    required this.profile,
    required this.message,
    required this.status,
  });

  factory AccountSetup.fromAccountSetupResponse(AccountSetupResponse response) {
    return AccountSetup(
      profile: Profile.fromProfileResponse(response.profileResponse),
      message: response.message,
      status: response.status,
    );
  }
}
