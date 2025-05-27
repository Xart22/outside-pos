import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pos_getx/app/data/provider/api_provider.dart';

class ProductsRepository {
  static createProduct(
      {required String name,
      required String price,
      required String description,
      required int categoryId,
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
      'stock': 0,
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
}
