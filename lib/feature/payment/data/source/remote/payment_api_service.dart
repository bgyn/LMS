import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lms/core/constants/url_constant.dart';
import 'package:lms/core/utils/shared_utility.dart';

class PaymentApiService {
  Future<String> createPaymentIntent(String amount, String courseId) async {
    final url = UrlConstant.createPaymentIntent();
    try {
      final token = await SharedUtility.getAccessToken();
      final response = await http.post(Uri.parse(url), headers: {
        "Authorization": "Bearer $token",
      }, body: {
        "amount": amount,
        "courseId": courseId,
      });
      if (response.statusCode == 200) {
        final clientScret = jsonDecode(response.body)['clientSecret'];
        return clientScret;
      } else if (response.statusCode == 400) {
        throw Exception(response.body);
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
