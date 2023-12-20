import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:my_app/network/models/tutor_api.dart';
import 'package:my_app/network/response/ErrorResponse.dart';

class TutorListRequest {
  static Future<dynamic> getTutorListPagination(
      String? token, int perPage, int page) async {
    final url =
        "https://sandbox.api.lettutor.com/tutor/more?perPage=$perPage&page=$page";
    final uri = Uri.parse(url);

    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    List<TutorApi> tutorsList = [];
    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      for (var i = 0; i < perPage; i++) {
        final tutorApi = TutorApi.fromJson(json['tutors']['rows'][i]);
        tutorsList.add(tutorApi);
      }
      return tutorsList;
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      final json = jsonDecode(response.body);
      final message = ErrorResponse.fromJson(json);
      return message;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
