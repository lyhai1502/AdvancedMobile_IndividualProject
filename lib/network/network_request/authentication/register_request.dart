import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/network/response/ErrorResponse.dart';
import 'package:my_app/network/response/SuccessResponse.dart';

class RegisterRequest {
  static Future<dynamic> register(
      String email, String password, String source) async {
    final body = {"email": email, "password": password, "source": source};
    const url = "https://sandbox.api.lettutor.com/auth/register";
    final uri = Uri.parse(url);

    final response = await http.post(uri, body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return SuccessResponse(message: 'Register successfully');
    } else if (response.statusCode == 400) {
      final json = jsonDecode(response.body);
      final message = ErrorResponse.fromJson(json);
      return message;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
