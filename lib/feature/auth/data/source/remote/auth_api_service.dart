import 'package:lms/core/constants/url_constant.dart';
import 'package:lms/core/services/device_info_service.dart';
import 'package:lms/core/services/notification_services.dart';
import 'package:lms/core/utils/shared_utility.dart';
import 'package:lms/feature/auth/domain/model/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthApiService {
  Future<AuthResponseModel> login(String email, String password) async {
    try {
      String url = UrlConstant.login();
      final fcmToken = await NotificationServices().getToken();
      final deviceInfo = await DeviceInfoService.getDeviceInfo();
      final response = await http.post(
        Uri.parse(url),
        body: {
          "email": email,
          "password": password,
          if (fcmToken != null) "fcmToken": fcmToken,
          if (deviceInfo != null) "deviceInfo": deviceInfo,
        },
      );

      if (response.statusCode == 200) {
        final res = AuthResponseModel.fromJson(response.body);
        if (res.accessToken == null && res.refreshToken == null) {
          throw Exception("Failed to Login");
        }
        return res;
      } else if (response.statusCode == 401) {
        throw Exception("Invalid email or password");
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<AuthResponseModel> register(
      String email, String password, String name) async {
    try {
      String url = UrlConstant.register();
      final fcmToken = await NotificationServices().getToken();
      final deviceInfo = await DeviceInfoService.getDeviceInfo();
      final response = await http.post(
        Uri.parse(url),
        body: {
          "email": email,
          "password": password,
          "name": name,
          if (fcmToken != null) "fcmToken": fcmToken,
          if (deviceInfo != null) "deviceInfo": deviceInfo,
        },
      );
      if (response.statusCode == 200) {
        final res = AuthResponseModel.fromJson(response.body);
        if (res.accessToken == null && res.refreshToken == null) {
          throw Exception("Failed to Register");
        }
        return res;
      } else if (response.statusCode == 400) {
        throw Exception("Email already exists");
      } else if (response.statusCode == 401) {
        throw Exception("Invalid email or password");
      } else {
        throw Exception("Failed to register");
      }
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<String?> verifyToken() async {
    try {
      final token = await SharedUtility.getAccessToken();
      if (token == null) {
        throw Exception("Token not found");
      }
      String url = UrlConstant.verifyToken();
      final response =
          await http.post(Uri.parse(url), body: {"accessToken": token});
      if (response.statusCode == 200) {
        return null;
      } else if (response.statusCode == 401) {
        final token = await _refreshToken();
        return token;
      } else {
        throw Exception("Failed to verify token");
      }
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<String> _refreshToken() async {
    try {
      final refreshToken = await SharedUtility.getRefreshToken();
      if (refreshToken == null) {
        throw Exception("Refresh token not found");
      }

      String url = UrlConstant.refreshToken();
      final response = await http.post(
        Uri.parse(url),
        body: {"refreshToken": refreshToken},
      );

      if (response.statusCode == 200) {
        final res = AuthResponseModel.fromJson(response.body);
        if (res.accessToken != null) {
          return res.accessToken!;
        } else {
          throw Exception("Invalid refresh token response");
        }
      } else if (response.statusCode == 401) {
        throw Exception("Session expired. Please log in again.");
      } else {
        throw Exception("Failed to refresh token");
      }
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
