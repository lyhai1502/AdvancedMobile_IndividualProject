import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/network/models/tutor_api.dart';
import 'package:my_app/network/response/ErrorResponse.dart';

class GetTutorInfoRequest {
  static Future<dynamic> getTutorInfo(String? token, String? tutorId) async {
    final url = "https://sandbox.api.lettutor.com/tutor/$tutorId";
    final uri = Uri.parse(url);

    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      final TutorApi tutorApi = TutorApi.fromJson2(json);
      return tutorApi;
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      final json = jsonDecode(response.body);
      final message = ErrorResponse.fromJson(json);
      return message;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
