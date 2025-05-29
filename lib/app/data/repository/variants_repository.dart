import 'dart:convert';

import 'package:pos_getx/app/data/model/variant_model.dart';
import 'package:pos_getx/app/data/provider/api_provider.dart';

class VariantsRepository {
  static Future<List<Variant>> getVariants() async {
    final response = await ApiClient.get('/variants');

    if (response.statusCode == 200) {
      return (List<Variant>.from(json
          .decode(response.body)['variants']
          .map((x) => Variant.fromJson(x))));
    } else {
      throw Exception('Failed to load variants');
    }
  }

  static Future<bool> createCategory(
      {required String name, required String icon}) {
    final requestBody = {
      'name': name,
      'icon': icon,
    };
    return ApiClient.post('/categories/store', requestBody).then((response) {
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        return false;
      } else {
        throw Exception('Failed to create category');
      }
    });
  }
}
