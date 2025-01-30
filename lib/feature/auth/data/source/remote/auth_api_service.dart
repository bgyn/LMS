import 'package:lms/core/constants/url_constant.dart';
import 'package:lms/core/services/device_info_service.dart';
import 'package:lms/core/services/notification_services.dart';
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
