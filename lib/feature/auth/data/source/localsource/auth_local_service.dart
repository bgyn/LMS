import 'package:lms/core/utils/shared_utility.dart';

class LocalAuthApiService {
  Future<String?> isUserLoggedIn() async {
    final response = await SharedUtility.getAccessToken();
    return response;
  }

  Future<String?> getAccessToken() async {
    final response = await SharedUtility.getAccessToken();
    return response;
  }

  Future<String?> getRefreshToken() async {
    final response = await SharedUtility.getRefreshToken();
    return response;
  }

  Future<void> saveAccessToken(String accessToken) async {
    SharedUtility.setAccessToken(accessToken);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    SharedUtility.setRefreshToken(refreshToken);
  }

  Future<void> deleteToken() async {
    SharedUtility.deleteToken();
  }
}
