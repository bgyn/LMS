import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lms/core/constants/url_constant.dart';
import 'package:lms/core/utils/shared_utility.dart';

class PaymentApiService {
  Future<String> createPaymentIntent(String amount, String courseId) async {
    final url = UrlConstant.createPaymentIntent();
    try {
      final token = await SharedUtility.getToken();
      final response = await http.post(Uri.parse(url), headers: {
        "Authorization": "Bearer $token",
      }, body: {
        "amount": amount,
        "courseId": courseId,
      });
      print(response.body);
      if (response.statusCode == 200) {
        final clientScret = jsonDecode(response.body)['clientSecret'];
        return clientScret;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
