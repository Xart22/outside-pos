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

  static Future<bool> createVariant(Variant variant) async {
    final requestBody = {
      'name': variant.name,
      'rules_min': variant.rulesMin,
      'rules_max': variant.rulesMax,
      'options': variant.options
          .map((option) => {
                'name': option.name,
                'price': option.price,
                'position': option.position,
              })
          .toList(),
    };

    return ApiClient.post('/variants/store', requestBody).then((response) {
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        return false;
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to create category');
      }
    });
  }

  static Future<bool> updateVariant(Variant variant) async {
    final requestBody = {
      'name': variant.name,
      'rules_min': variant.rulesMin,
      'rules_max': variant.rulesMax,
      'options': variant.options
          .map((option) => {
                'name': option.name,
                'price': option.price,
                'position': option.position,
              })
          .toList(),
    };

    return ApiClient.post('/variants/update/${variant.id}', requestBody)
        .then((response) {
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        return false;
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to update variant');
      }
    });
  }

  static Future<bool> deleteVariant(int id) async {
    final response = await ApiClient.delete('/variants/delete/$id');

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      return false;
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to delete variant');
    }
  }
}
