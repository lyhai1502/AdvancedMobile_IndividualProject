import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/network/network_response/error_response.dart';
import 'package:my_app/network/network_response/sucess_response.dart';

class BookingClassRequest {
  static Future<dynamic> bookingClass(
      String? token, String? scheduleId, String? note) async {
    const String url = 'https://sandbox.api.lettutor.com/booking';

    final body = {
      "scheduleDetailIds": [scheduleId],
      "note": note
    };

    final uri = Uri.parse(url);
    final response = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      final message = json['message'];
      return SuccessResponse(message: message);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      final json = jsonDecode(response.body);
      final message = ErrorResponse.fromJson(json);
      return message;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
