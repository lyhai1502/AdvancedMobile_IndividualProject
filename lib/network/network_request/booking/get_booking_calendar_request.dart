import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/network/model/booking_info_api.dart';
import 'package:my_app/network/network_response/error_response.dart';

class GetBookingCalendarRequest {
  static Future<dynamic> getBookingCalendar(
      String? token, String? tutorId) async {
    final String url =
        'https://sandbox.api.lettutor.com/schedule?tutorId=$tutorId&page=0';

    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    List<BookingInfoApi> bookingInfoApiList = [];
    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      for (var i = 0; i < json['scheduleOfTutor'].length; i++) {
        final bookingInfoApi =
            BookingInfoApi.fromJson(json['scheduleOfTutor'][i]);
        bookingInfoApiList.add(bookingInfoApi);
      }

      return bookingInfoApiList;
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      final json = jsonDecode(response.body);
      final message = ErrorResponse.fromJson(json);
      return message;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
