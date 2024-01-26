import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:my_app/network/model/course_api.dart';
import 'package:my_app/network/network_response/error_response.dart';

class EbookListRequest {
  static Future<dynamic> getEbookList(
      String? token, int perPage, int page) async {
    final url =
        "https://sandbox.api.lettutor.com/e-book?page=$page&size=$perPage";
    final uri = Uri.parse(url);

    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    List<CourseApi> courseList = [];
    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      for (var i = 0; i < min(perPage, json['data']['rows'].length); i++) {
        final courseApi = CourseApi.fromJson(json['data']['rows'][i]);
        courseList.add(courseApi);
      }

      return courseList;
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      final json = jsonDecode(response.body);
      final message = ErrorResponse.fromJson(json);
      return message;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
