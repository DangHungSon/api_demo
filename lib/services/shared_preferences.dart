import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKeys {
  SharedPrefKeys._();

  static const String languageCd = 'languageCd';
  static const String themeFlag = 'themeFlag';
  static const String loginToken = 'token';
}

class SharedPreferencesService {
  static late SharedPreferencesService _instance;
  static late SharedPreferences _preferences;

  SharedPreferencesService._internal();

  static Future<SharedPreferencesService> get instance async {
    _instance = SharedPreferencesService._internal();

    _preferences = await SharedPreferences.getInstance();

    return _instance;
  }

  // Set language local
  Future<void> setLanguage(String langCode) async =>
      await _preferences.setString(SharedPrefKeys.languageCd, langCode);

  // Get language local
  String get languageCode =>
      _preferences.getString(SharedPrefKeys.languageCd) ?? '';

  // Set theme local
  Future<void> setTheme(bool isDarkMode) async =>
      await _preferences.setBool(SharedPrefKeys.themeFlag, isDarkMode);

  // Get theme local
  bool get isDarkMode =>
      _preferences.getBool(SharedPrefKeys.themeFlag) ?? false;

  // Set token local
  Future<void> setToken(String accessToken) async =>
      await _preferences.setString(SharedPrefKeys.loginToken, accessToken);

  // Get token local
  String get accessToken => _preferences.getString(SharedPrefKeys.loginToken) ?? '';

  // Delete token local
  Future<bool> get removeToken => _preferences.remove(SharedPrefKeys.loginToken);

}
