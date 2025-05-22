import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

const baseUrl = 'http://192.168.1.2/pos/public/api/';

class ApiClient {
  final http.Client httpClient;
  ApiClient({required this.httpClient});

  Future<http.Response> get(String endpoint) async {
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
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final box = GetStorage();
      String? token = box.read('token');
      final response = await httpClient.post(
        Uri.parse(baseUrl + endpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: body,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final box = GetStorage();
      String? token = box.read('token');
      final response = await httpClient.put(
        Uri.parse(baseUrl + endpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: body,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> delete(String endpoint) async {
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

  Future<http.Response> upload(
      String endpoint, Map<String, dynamic> body, String filePath) async {
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
      });
      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      request.fields
          .addAll(body.map((key, value) => MapEntry(key, value.toString())));
      var response = await request.send();
      return await http.Response.fromStream(response);
    } catch (e) {
      rethrow;
    }
  }
}
