import 'dart:convert';
import 'dart:io';

import 'package:lms/core/constants/url_constant.dart';
import 'package:lms/core/utils/shared_utility.dart';
import 'package:lms/feature/profile/domain/model/profile_model.dart';
import 'package:http/http.dart' as http;

class ProfileApiService {
  Future<ProfileModel> getProfile() async {
    final url = UrlConstant.profile();
    try {
      final token = await SharedUtility.getAccessToken();
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer $token",
      });
      final res = json.decode(response.body);
      if (response.statusCode == 404) {
        throw Exception("User not found");
      }
      if (response.statusCode == 400) {
        throw Exception(jsonDecode(response.body)["message"]);
      }
      return ProfileModel.fromMap(res);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ProfileModel> updateProfile(
      {File? file, String? name, String? bio}) async {
    final url = UrlConstant.profile();
    try {
      final token = await SharedUtility.getAccessToken();
      final request = http.MultipartRequest("PATCH", Uri.parse(url));
      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      };
      request.headers.addAll(headers);
      if (file != null) {
        request.files.add(
          await http.MultipartFile.fromPath("profileImage", file.path),
        );
      }
      if (name != null) request.fields["name"] = name;
      if (bio != null) request.fields["bio"] = bio;
      final response = await request.send();
      final res = await http.Response.fromStream(response);
      final data = json.decode(res.body);
      if (res.statusCode == 404) {
        throw Exception("User not found");
      }
      if (res.statusCode == 400) {
        throw Exception(data["message"]);
      }
      return ProfileModel.fromMap(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
