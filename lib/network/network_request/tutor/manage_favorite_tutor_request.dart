import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;

class ManageFavoriteTutorRequest {
  static Future<void> manageFavoriteTutor(String token, String tutorId) async {
    const url = "https://sandbox.api.lettutor.com/user/manageFavoriteTutor";
    final uri = Uri.parse(url);

    final response = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"tutorId": tutorId}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    }
  }
}
