import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/network/model/tutor_api.dart';
import 'package:my_app/network/network_response/error_response.dart';

class SearchFilterTutorRequest {
  static Future<dynamic> searchTutor(
      String? token, String keyword, int perPage, int page) async {
    final body = {"search": keyword, "perPage": perPage, "page": page};
    const url = "https://sandbox.api.lettutor.com/tutor/search";
    final uri = Uri.parse(url);

    final response = await http.post(uri, body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    List<TutorApi> tutorsList = [];
    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      for (var i = 0; i < json['rows'].length; i++) {
        final tutorApi = TutorApi.fromJson(json['rows'][i]);
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

  static Future<dynamic> filterTutor(
      String? token, String keyword, int perPage, int page) async {
    final body = {
      "filters": {
        "specialties": [keyword]
      },
      "page": page,
      "perPage": perPage
    };
    const url = "https://sandbox.api.lettutor.com/tutor/search";
    final uri = Uri.parse(url);

    final response = await http.post(uri, body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    List<TutorApi> tutorsList = [];
    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      for (var i = 0; i < json['rows'].length; i++) {
        final tutorApi = TutorApi.fromJson(json['rows'][i]);
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
