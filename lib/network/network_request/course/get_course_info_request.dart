import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:my_app/network/models/course_api.dart';
import 'package:my_app/network/response/error_response.dart';

class CourseInfoRequest {
  static Future<dynamic> getCourseInfo(String? token, String? courseId) async {
    final url = "https://sandbox.api.lettutor.com/course/$courseId";
    final uri = Uri.parse(url);

    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      final course = CourseApi.fromJson(json['data']);
      return course;
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      final json = jsonDecode(response.body);
      final message = ErrorResponse.fromJson(json);
      return message;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
