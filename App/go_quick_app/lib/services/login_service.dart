import 'dart:convert';
import 'dart:ffi';

import 'package:go_quick_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class LoginService {
  Future<String> login(String username, String password) async {
    final response = await http.post(Uri.parse(api + 'login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'username': username, 'password': password}));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Failed to login");
    }
  }
}
