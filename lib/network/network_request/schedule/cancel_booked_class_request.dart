import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/network/response/error_response.dart';
import 'package:my_app/network/response/sucess_response.dart';

class CancelBookedClassRequest {
  static Future<dynamic> cancelBookedClass(
      String? token, String deleteId) async {
    const String url = 'https://sandbox.api.lettutor.com/booking';
    final body = {
      "scheduleDetailIds": [deleteId]
    };

    final uri = Uri.parse(url);
    final response = await http.delete(uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return SuccessResponse(message: 'Delete sucessfully');
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      final json = jsonDecode(response.body);
      final message = ErrorResponse.fromJson(json);
      return message;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
