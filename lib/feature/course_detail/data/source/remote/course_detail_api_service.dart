import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lms/core/constants/url_constant.dart';
import 'package:lms/core/utils/shared_utility.dart';
import 'package:lms/feature/course/domain/model/course_model.dart';

class CourseDetailApiService {
  Future<CourseModel> getCourseById(String id) async {
    final url = UrlConstant.courseById(id);
    try {
      final token = await SharedUtility.getAccessToken();
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer $token",
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = json.decode(response.body);
        final CourseModel course = CourseModel.fromJson(result["course"]);
        return course;
      } else {
        throw Exception('Failed to load course');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
