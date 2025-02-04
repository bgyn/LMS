import 'dart:convert';

import 'package:lms/core/constants/url_constant.dart';
import 'package:lms/core/utils/shared_utility.dart';
import 'package:lms/feature/course/domain/model/course_model.dart';
import 'package:http/http.dart' as http;

class CourseApiService {
  Future<List<CourseModel>> getCourses() async {
    final url = UrlConstant.allCourse();

    try {
      final token = await SharedUtility.getAccessToken();
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer $token",
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> result = json.decode(response.body);
        final List<CourseModel> courses = (result["course"] as List)
            .map((e) => CourseModel.fromJson(e))
            .toList();
        return courses;
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
