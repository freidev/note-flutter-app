import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  final String baseUrl = "http://192.168.10.55:3000/api/";
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<http.Response> get(String endpoint) async {
    final response = await http.get(
      Uri.parse(baseUrl + endpoint),
      headers: headers,
    );
    return response;
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse(baseUrl + endpoint),
      headers: headers,
      body: jsonEncode(body),
    );
    return response;
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final response = await http.put(
      Uri.parse(baseUrl + endpoint),
      headers: headers,
      body: jsonEncode(body),
    );
    return response;
  }
}
