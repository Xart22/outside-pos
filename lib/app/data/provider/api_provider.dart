import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

// const baseUrl = 'https://team.outsidecoffee.id/api';
const baseUrl = 'http://192.168.1.4/outside-pos/public/api';

class ApiClient {
  static final http.Client httpClient = http.Client();

  static Future<http.Response> get(String endpoint) async {
    try {
      final box = GetStorage();
      String? token = box.read('token');
      final response = await httpClient.get(
        Uri.parse(baseUrl + endpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> post(
      String endpoint, Map<String, dynamic> body) async {
    try {
      final box = GetStorage();
      String? token = box.read('token');
      final response = await httpClient.post(
        Uri.parse(baseUrl + endpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> put(
      String endpoint, Map<String, dynamic> body) async {
    try {
      final box = GetStorage();
      String? token = box.read('token');

      final response = await httpClient.put(
        Uri.parse(baseUrl + endpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> delete(String endpoint) async {
    try {
      final box = GetStorage();
      String? token = box.read('token');
      final response = await httpClient.delete(
        Uri.parse(baseUrl + endpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> upload(
      String endpoint, Map<String, dynamic> body, String? filePath) async {
    try {
      final box = GetStorage();
      String? token = box.read('token');
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(baseUrl + endpoint),
      );
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
      });
      if (filePath != null) {
        request.files.add(await http.MultipartFile.fromPath('image', filePath));
      }
      request.fields
          .addAll(body.map((key, value) => MapEntry(key, value.toString())));
      var response = await request.send();
      return await http.Response.fromStream(response);
    } catch (e) {
      rethrow;
    }
  }
}
