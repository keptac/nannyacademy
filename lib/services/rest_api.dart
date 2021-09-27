import 'dart:convert';

import 'package:http/http.dart' as http;

class URLS {
  static const String BASE_URL = 'http://localhost:3000/api/v1';
}

class ApiService {

  static Future<bool> login(body) async {
    final response = await http.post('${URLS.BASE_URL}/login', body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<dynamic> registerUser(body) async {
    final response = await http.post('${URLS.BASE_URL}/users', body: body);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  static Future<dynamic> applicationReg(body) async {
    final response = await http.post('${URLS.BASE_URL}/verify/registrar',
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }

  static Future<dynamic> authReg(body) async {
    final response = await http.post('${URLS.BASE_URL}/auth/register',
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return false;
    }
  }
}
