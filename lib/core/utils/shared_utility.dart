import 'package:shared_preferences/shared_preferences.dart';

class SharedUtility {
  static SharedUtility? _instance;
  static SharedPreferences? _pref;
  static const String _onboarding = 'onboarding';

  factory SharedUtility() {
    if (_instance == null) {
      throw Exception('Ensure shared preference is initalized.');
    }
    return _instance!;
  }

  //private constructor
  const SharedUtility._();

  static const String _tokenKey = "token";
  static const String _refreshToken = "refreshToken";

  static enxureInitialized() async {
    _pref ??= await SharedPreferences.getInstance();
    _instance ??= const SharedUtility._();
  }

  static Future<void> setIsOnboarding() async {
    await _pref!.setBool(_onboarding, true);
  }

  static bool getIsOnboarding() {
    return _pref!.getBool(_onboarding) ?? false;
  }

  static void setAccessToken(String token) async {
    await _pref!.setString(_tokenKey, token);
  }

  static void setRefreshToken(String token) async {
    await _pref!.setString(_refreshToken, token);
  }

  static Future<String?> getAccessToken() async {
    final String? token = _pref!.getString(_tokenKey);
    if (token != null) {
      return token;
    }
    return null;
  }

  static Future<String?> getRefreshToken() async {
    final String? token = _pref!.getString(_refreshToken);
    if (token != null) {
      return token;
    }
    return null;
  }

  static void deleteToken() async {
    await _pref!.remove(_tokenKey);
    await _pref!.remove(_refreshToken);
  }
}
