import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pos_getx/app/data/model/menu_model.dart';
import 'package:pos_getx/app/data/provider/api_provider.dart';

class ProductsRepository {
  static Future<List<Menu>> getProducts() async {
    final response = await ApiClient.get('/menu');
    if (response.statusCode == 200) {
      return (List<Menu>.from(
          json.decode(response.body)['menu'].map((x) => Menu.fromJson(x))));
    } else {
      print('Failed to load products: ${response.statusCode}');
      throw Exception('Failed to load products');
    }
  }

  static Future<bool> createProduct(
      {required String name,
      required String price,
      required String description,
      required int categoryId,
      required String stock,
      File? imageFile,
      bool isOnline = false}) async {
    var imageLocal = "";

    if (imageFile != null) {
      final String path = await getApplicationDocumentsDirectory()
          .then((directory) => directory.path);
      final String fileName = imageFile.path.split('/').last;
      final File localFile = File('$path/$fileName');
      await imageFile.copy(localFile.path);
      imageLocal = localFile.path;
    }

    final requestBody = {
      'name': name,
      'price': price.replaceAll('Rp.', '').replaceAll('.', '').trim(),
      'description': description,
      'category_id': categoryId,
      'is_online': isOnline == true ? 1 : 0,
      'image_local': imageLocal,
      'stock': stock,
    };

    return ApiClient.upload('/menu/store', requestBody, imageFile!.path)
        .then((response) {
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        return false;
      } else {
        throw Exception('Failed to create product');
      }
    });
  }

  static Future<bool> updateProduct(
      {required int id,
      required String name,
      required String price,
      required String description,
      required int categoryId,
      required String stock,
      File? imageFile,
      bool isOnline = false}) async {
    var imageLocal = "";

    if (imageFile != null) {
      final String path = await getApplicationDocumentsDirectory()
          .then((directory) => directory.path);
      final String fileName = imageFile.path.split('/').last;
      final File localFile = File('$path/$fileName');
      await imageFile.copy(localFile.path);
      imageLocal = localFile.path;
    }

    final requestBody = {
      'name': name,
      'price': price.replaceAll('Rp.', '').replaceAll('.', '').trim(),
      'description': description,
      'category_id': categoryId,
      'is_online': isOnline == true ? 1 : 0,
      if (imageLocal != "") 'image_local': imageLocal,
      'stock': stock,
    };

    return ApiClient.upload('/menu/update/$id', requestBody, imageFile?.path)
        .then((response) {
      if (response.statusCode == 200) {
        print('Product updated successfully');
        print('Response: ${response.body}');
        return true;
      } else if (response.statusCode == 400) {
        return false;
      } else {
        throw Exception('Failed to create product');
      }
    });
  }
}
