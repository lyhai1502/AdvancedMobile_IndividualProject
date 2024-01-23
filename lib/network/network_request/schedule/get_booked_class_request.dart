import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:my_app/network/models/schedule_api.dart';
import 'package:my_app/network/response/error_response.dart';

class GetBookedClassRequest {
  static Future<dynamic> getBookedClass(String? token, int page, int perPage,
      int? dateTimeLte, String orderBy, String sortBy) async {
    final String url;
    if (dateTimeLte == null) {
      url =
          'https://sandbox.api.lettutor.com/booking/list/student?page=$page&perPage=$perPage&inFuture=1&orderBy=$orderBy&sortBy=$sortBy';
    } else {
      url =
          'https://sandbox.api.lettutor.com/booking/list/student?page=$page&perPage=$perPage&inFuture=0&dateTimeLte=$dateTimeLte&orderBy=$orderBy&sortBy=$sortBy';
    }

    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });
    List<ScheduleApi> scheduleList = [];
    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      for (var i = 0; i < min(json['data']['count'], perPage); i++) {
        final scheduleApi = ScheduleApi.fromJson(json['data']['rows'][i]);
        scheduleList.add(scheduleApi);
      }
      return scheduleList;
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      final json = jsonDecode(response.body);
      final message = ErrorResponse.fromJson(json);
      return message;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
