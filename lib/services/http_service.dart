import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  final String baseUrl = "http://192.168.10.55:3000/api/";

  Future<http.Response> get(String endpoint) async {
    final response = await http.get(Uri.parse(baseUrl + endpoint));
    return response;
  }

  Future<http.Response> post(String endpoint, dynamic body) async {
    final response = await http.post(Uri.parse(baseUrl + endpoint), body: body);
    return response;
  }

  // Agrega aquí más métodos para PUT, DELETE, etc., si son necesarios
}
