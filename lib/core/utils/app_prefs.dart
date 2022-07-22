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

  Future<String?> getUserStatus() async {
    String? status = _sharedPreferences.getString(AppConstants.userStatus);
    return status;
  }

  Future<void> saveUserStatus(String status) async {
    _sharedPreferences.setString(AppConstants.userStatus, status);
  }

  Future<void> cleanPreference() async {
    await _sharedPreferences.clear();
  }
}
