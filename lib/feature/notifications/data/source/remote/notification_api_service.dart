import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lms/core/constants/url_constant.dart';
import 'package:lms/core/utils/shared_utility.dart';
import 'package:lms/feature/notifications/domain/model/notification_model.dart';

class NotificationApiService {
  Future<List<NotificationModel>> fetchNotification() async {
    final url = UrlConstant.notifcation();

    try {
      final token = await SharedUtility.getAccessToken();
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer $token",
      });
      if (response.statusCode == 200) {
        final notifications = notificationModelFromMap(response.body);
        return notifications;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception(jsonDecode(response.body)["message"]);
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<void> markAsRead(String id) async {
    final url = UrlConstant.markAsRead(id);

    try {
      final token = await SharedUtility.getAccessToken();
      final response = await http.patch(Uri.parse(url), headers: {
        "Authorization": "Bearer $token",
      });
      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 404) {
        throw Exception("Notification not found");
      } else {
        throw Exception(jsonDecode(response.body)["message"]);
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<void> markAllAsRead() async {
    final url = UrlConstant.markAllAsRead();
    try {
      final token = await SharedUtility.getAccessToken();
      final response = await http.patch(Uri.parse(url),headers:{
         "Authorization": "Bearer $token",
      });
      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 404) {
        throw Exception("Notification not found");
      } else {
        throw Exception(jsonDecode(response.body)["message"]);
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
