import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/network/models/schedule_api.dart';
import 'package:my_app/network/response/error_response.dart';

class GetUpcomingClassRequest {
  static Future<dynamic> getUpComingClass(String? token) async {
    const String url = 'https://sandbox.api.lettutor.com/booking/next';

    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      final scheduleApi = ScheduleApi.fromJson(json['data'][0]);
      return scheduleApi;
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      final json = jsonDecode(response.body);
      final message = ErrorResponse.fromJson(json);
      return message;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<dynamic> getTotalHours(String? token) async {
    const String url = 'https://sandbox.api.lettutor.com/call/total';

    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return json['total'];
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      final json = jsonDecode(response.body);
      final message = ErrorResponse.fromJson(json);
      return message;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
