import 'dart:convert';

import 'package:pos_getx/app/data/model/settings_model.dart';
import 'package:pos_getx/app/data/provider/api_provider.dart';

class SettingsRepository {
  static Future<SettingsModel> loadSettings() async {
    final data = await ApiClient.get('/settings');
    if (data.statusCode == 200) {
      return SettingsModel.fromJson(json.decode(data.body));
    } else {
      throw Exception('Failed to load settings');
    }
  }

  static Future<bool> updateSettings(List<Map<String, String>> settings) async {
    final requestBody = {
      'data': settings,
    };
    final response = await ApiClient.put('/settings', requestBody);
    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }
}
