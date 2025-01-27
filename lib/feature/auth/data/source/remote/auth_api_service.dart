import 'package:lms/feature/auth/domain/model/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthApiService {
  Future<AuthResponseModel> login(String email, String password) async {
    try {
      const url = "http://192.168.1.214:3000/api/v1";
      final response = await http.post(
        Uri.parse("$url/auth/login"),
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
      const url = "http://192.168.1.214:3000/api/v1";
      final response = await http.post(
        Uri.parse("$url/auth/register"),
        body: {
          "email": email,
          "password": password,
          "name": name,
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

  Future<void> logout() async {}
}
