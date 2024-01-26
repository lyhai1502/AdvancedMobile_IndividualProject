import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:my_app/network/model/schedule_api.dart';
import 'package:my_app/network/network_response/error_response.dart';

class GetHistoryBookedClassRequest {
  static Future<dynamic> getHistoryBookedClass(String? token, int page, int perPage,
      String orderBy, String sortBy) async {
    final String url = 
          'https://sandbox.api.lettutor.com/booking/list/student?page=$page&perPage=$perPage&inFuture=0&orderBy=$orderBy&sortBy=$sortBy';

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
