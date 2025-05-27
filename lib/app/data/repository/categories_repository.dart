import 'dart:convert';

import 'package:pos_getx/app/data/model/categories_model.dart';
import 'package:pos_getx/app/data/provider/api_provider.dart';

class CategoriesRepository {
  static Future<List<Category>> getCategories() async {
    final response = await ApiClient.get('/categories');
    if (response.statusCode == 200) {
      return CategoriesModel.fromJson(json.decode(response.body)).categories;
    } else {
      throw Exception('Failed to load categories');
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
