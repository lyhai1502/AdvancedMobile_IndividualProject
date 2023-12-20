import 'dart:convert';
import 'package:http/http.dart' as http;

class ResetPasswordRequest {
  static Future<void> resetPassword(String email) {
    return http.post(
      Uri.parse('https://sandbox.api.lettutor.com/user/forgotPassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );
  }
}
