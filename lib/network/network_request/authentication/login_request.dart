import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/api/static_api.dart';
import 'package:my_app/network/network_reponse/error_response.dart';
import 'package:my_app/network/model/tokens.dart';

class LoginRequest {
  static Future<dynamic> login(String email, String password) async {
    final body = {
      "email": email,
      "password": password,
    };
    const url = StaticApi.LOGIN_URL;
    final uri = Uri.parse(url);

    final response = await http.post(uri, body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      final tokens = Tokens.fromJson(json['tokens']);
      return tokens;
    } else if (response.statusCode == 400) {
      final json = jsonDecode(response.body);
      final message = ErrorResponse.fromJson(json);
      return message;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
