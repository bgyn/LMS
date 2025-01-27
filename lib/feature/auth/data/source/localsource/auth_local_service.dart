import 'package:lms/core/utils/shared_utility.dart';

class LocalAuthApiService {
  Future<String?> isUserLoggedIn() async {
    final response = await SharedUtility.getToken();
    return response;
  }

  Future<void> saveToken(String token) async {
    SharedUtility.setToken(token);
  }

  Future<void> deleteToken() async {
    SharedUtility.deleteToken();
  }
}
