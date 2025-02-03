import 'package:lms/core/constants/url_constant.dart';
import 'package:http/http.dart' as http;

class PasswordResetApiService {
  Future<void> sendPasswordResetRequest(String email) async {
    try {
      String url = UrlConstant.passwordResetRequest();
      final response = await http.post(
        Uri.parse(url),
        body: {
          "email": email,
        },
      );
      if (response.statusCode == 404) {
        throw Exception("Email not found");
      }
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<void> passwordReset(String email, String password) async {
    try {
      String url = UrlConstant.passwordReset();
      final response = await http.post(
        Uri.parse(url),
        body: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 404) {
        throw Exception("Email not found");
      }
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    try {
      String url = UrlConstant.verifyOtp();
      final response = await http.post(
        Uri.parse(url),
        body: {
          "email": email,
          "otp": otp,
        },
      );

      if (response.statusCode == 400 || response.statusCode == 404) {
        throw Exception("Invalid OTP");
      }
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
