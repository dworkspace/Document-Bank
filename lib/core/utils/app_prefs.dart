import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String?> getAccessToken() async {
    String? accessToken =
        _sharedPreferences.getString(AppConstants.accessToken);
    return accessToken;
  }

  Future<void> saveAccessToken(String accessToken) async {
    _sharedPreferences.setString(AppConstants.accessToken, accessToken);
  }
}
