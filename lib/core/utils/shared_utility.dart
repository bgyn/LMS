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

  static void setToken(String token) async {
    await _pref!.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final String? token = _pref!.getString(_tokenKey);
    if (token != null) {
      return token;
    }
    return null;
  }

  static void deleteToken() async {
    await _pref!.remove(_tokenKey);
  }
}
