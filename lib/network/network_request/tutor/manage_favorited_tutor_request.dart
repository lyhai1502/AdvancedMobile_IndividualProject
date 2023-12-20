import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/network/response/ErrorResponse.dart';
import 'package:my_app/network/response/SuccessResponse.dart';
class ManageFavoritedTutorRequest{
  static Future<dynamic> getFavoritedTutorList(String token, String idTutor) async {
    final body = {"tutorId": idTutor};
    const url = "https://sandbox.api.lettutor.com/user/manageFavoriteTutor";
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return SuccessResponse(message: 'Get favorited tutor list successfully');
    } else if (response.statusCode == 400) {
      final json = jsonDecode(response.body);
      final message = ErrorResponse.fromJson(json);
      return message;
    } else {
      throw Exception('Failed to load data');
    }
  }
}