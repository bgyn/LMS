import "dart:convert";

import "package:http/http.dart" as http;
import "package:lms/core/constants/url_constant.dart";
import "package:lms/core/utils/shared_utility.dart";
import "package:lms/feature/my_course/domain/model/my_courses_model.dart";

class MyCourseApiService {
  Future<List<MyCourseModel>> getMyCourses() async {
    final url = UrlConstant.myEnrollment();
    try {
      final token = await SharedUtility.getAccessToken();

      final response = await http
          .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200) {
        final res = myCourseModelFromMap(response.body);
        return res;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception(jsonDecode(response.body)["message"]);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
