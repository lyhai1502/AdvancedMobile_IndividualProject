import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/network/network_response/error_response.dart';
import 'package:my_app/network/network_response/sucess_response.dart';

class ReportTutorRequest {
  static Future<dynamic> reportTutor(
      String? token, String? tutorId, String? content) async {
    final body = {"tutorId": tutorId, "content": content};
    const url = "https://sandbox.api.lettutor.com/report";
    final uri = Uri.parse(url);

    final response = await http.post(uri, body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return SuccessResponse(message: json['message']);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      final json = jsonDecode(response.body);
      final message = ErrorResponse.fromJson(json);
      return message;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
