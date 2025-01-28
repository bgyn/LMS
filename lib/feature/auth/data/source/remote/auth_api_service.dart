import 'package:lms/core/constants/url_constant.dart';
import 'package:lms/feature/auth/domain/model/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthApiService {
  Future<AuthResponseModel> login(String email, String password) async {
    try {
      String url = UrlConstant.login();
      final response = await http.post(
        Uri.parse(url),
        body: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 401) {
        throw Exception("Invalid email or password");
      }
      final res = AuthResponseModel.fromJson(response.body);
      return res;
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<AuthResponseModel> register(
      String email, String password, String name) async {
    try {
      String url = UrlConstant.register();
      final response = await http.post(
        Uri.parse(url),
        body: {
          "email": email,
          "password": password,
          "name": name,
        },
      );
      if (response.statusCode == 400) {
        throw Exception("Email already exists");
      }
      if (response.statusCode == 401) {
        throw Exception("Invalid email or password");
      }
      final res = AuthResponseModel.fromJson(response.body);
      return res;
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
