import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/api/static_api.dart';
import 'package:my_app/network/network_response/error_response.dart';
import 'package:my_app/network/network_response/sucess_response.dart';

class RegisterRequest {
  static Future<dynamic> register(
      String email, String password, String source) async {
    final body = {"email": email, "password": password, "source": source};
    const url = StaticApi.REGISTER_URL;
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
