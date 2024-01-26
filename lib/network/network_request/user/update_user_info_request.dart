import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/network/model/user_api.dart';
import 'package:my_app/network/network_response/error_response.dart';

class UpdateUserInfoRequest {
  static Future<dynamic> updateUserInfo(
      String? token,
      String? name,
      String? country,
      // String? phoneNumber,
      String? birthday,
      String? level,
      String? studySchedule,
      String? avatar
      // List<int>? learnTopics,
      // List<int>? testPreparations
      ) async {
    const url = "https://sandbox.api.lettutor.com/user/info";
    final uri = Uri.parse(url);

    final response = await http.put(uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(<String, String?>{
          "name": name ?? "",
          "country": country ?? "",
          // "phone": phoneNumber,
          "birthday": birthday ?? "",
          "level": level ?? "",
          "studySchedule": studySchedule ?? "",
          "avatar": avatar ?? ""
          // "learnTopics": learnTopics.toString(),
          // "testPreparations": testPreparations.toString(),
        }));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      final UserApi userApi = UserApi.fromJson(json['user']);
      return userApi;
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      final json = jsonDecode(response.body);
      final message = ErrorResponse.fromJson(json);
      return message;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
