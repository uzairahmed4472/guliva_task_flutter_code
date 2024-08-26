import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:guliva_interview_task/models/userData_model.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class AuthService {
  static Future<UserLoginModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse("${Constants.baseURL}/user/login"),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              "email": email,
              "password": password,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 400) {
        final body = jsonDecode(response.body);
        throw body['message'];
      } else if (response.statusCode == 401) {
        throw "Unauthorized: Invalid email or password.";
      } else if (response.statusCode == 500) {
        throw "Server Error: Please try again later.";
      } else if (response.statusCode != 200) {
        throw "Unexpected Error: ${response.statusCode}";
      }

      final body = jsonDecode(response.body);

      return UserLoginModel.fromJson(body);
    } on SocketException {
      throw "No Internet Connection Found";
    } on TimeoutException {
      throw "Request Timeout: Taking too long to respond.";
    } catch (e) {
      throw "An unexpected error occurred: $e";
    }
  }

  static Future<Map<String, dynamic>> signUp({
    required String firstName,
    required String lastName,
    required String phoneNo,
    required String email,
    required String dob,
    required String password,
    required bool withEmail,
  }) async {
    final url = '${Constants.baseURL}/user/register';
    final headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.post(Uri.parse(url),
          headers: headers,
          body: json.encode({
            "firstName": firstName,
            "lastName": lastName,
            "dob": dob,
            "email": email,
            "phoneNo": phoneNo,
            "password": password,
            "withEmail": withEmail,
          }));

      if (response.statusCode == 400) {
        final body = jsonDecode(response.body);
        throw body['message'];
      } else if (response.statusCode == 401) {
        throw "Unauthorized: Invalid email or password.";
      } else if (response.statusCode == 500) {
        throw "Server Error: Please try again later.";
      } else if (response.statusCode != 200) {
        throw "Unexpected Error: ${response.statusCode}";
      }

      final body = jsonDecode(response.body);
      return body;
    } on SocketException {
      throw "No Internet Connection Found";
    } on TimeoutException {
      throw "Request Timeout: Taking too long to respond.";
    } catch (e) {
      throw "An unexpected error occurred: $e";
    }
  }
}
