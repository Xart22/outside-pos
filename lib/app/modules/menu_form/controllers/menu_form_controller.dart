import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_getx/app/data/model/categories_model.dart';
import 'package:pos_getx/app/data/model/menu_model.dart';
import 'package:pos_getx/app/data/model/variant_model.dart';
import 'package:pos_getx/app/data/repository/categories_repository.dart';
import 'package:pos_getx/app/data/repository/products_repository.dart';
import 'package:pos_getx/app/data/repository/variants_repository.dart';
import 'package:pos_getx/app/style/app_colors.dart';
import 'package:pos_getx/app/widgets/snackbar.dart';

class MenuFormController extends GetxController {
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  final nameError = ''.obs;
  final priceError = ''.obs;
  final descriptionError = ''.obs;
  final categorySelected = 0.obs;
  final stockError = ''.obs;
  final isActive = false.obs;
  final isOnline = false.obs;
  final listCategories = <Category>[].obs;
  final listVariant = <Variant>[].obs;
  final listSelectedVariant = <Variant>[].obs;
  final imageFile = Rx<XFile?>(null);
  final menu = Rx<Menu?>(null);

  final editMode = false.obs;

  void getData() async {
    listCategories.value = await CategoriesRepository.getCategories();
    listVariant.value = await VariantsRepository.getVariants();
  }

  void showVariantDialog() {
    Get.defaultDialog(
      title: 'Pilih Variants',
      backgroundColor: const Color.fromARGB(255, 52, 52, 52),
      titleStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      content: SizedBox(
        height: 300,
        width: Get.width * 0.8,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: listVariant.length,
          itemBuilder: (context, index) {
            final variant = listVariant[index];
            return Card(
              child: Obx(() {
                final isSelected = listSelectedVariant.contains(variant);
                return CheckboxListTile(
                  title: Text(variant.name),
                  value: isSelected,
                  activeColor: AppColors.primary,
                  onChanged: (bool? value) {
                    if (value == true) {
                      variant.position = listSelectedVariant.length + 1;
                      listSelectedVariant.add(variant);
                    } else {
                      listSelectedVariant.remove(variant);
                    }
                  },
                );
              }),
            );
          },
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () => Get.back(),
        child: Text('OK'),
      ),
    );
  }

  void reorderVariant(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;

    final item = listSelectedVariant.removeAt(oldIndex);
    listSelectedVariant.insert(newIndex, item);

    for (int i = 0; i < listSelectedVariant.length; i++) {
      listSelectedVariant[i].position = i + 1;
    }
  }

  Future<bool> validateForm() async {
    nameError.value = '';
    priceError.value = '';
    descriptionError.value = '';
    stockError.value = '';

    if (nameController.text.isEmpty) {
      nameError.value = 'Nama tidak boleh kosong';
      return false;
    }
    if (priceController.text.isEmpty) {
      priceError.value = 'Harga tidak boleh kosong';
      return false;
    }
    if (descriptionController.text.isEmpty) {
      descriptionError.value = 'Deskripsi tidak boleh kosong';
      return false;
    }
    if (stockController.text.isEmpty) {
      stockError.value = 'Stok tidak boleh kosong';
      return false;
    }
    if (categorySelected.value == 0) {
      showSnackbar(
        "Peringatan",
        "Silakan pilih kategori untuk produk ini",
      );
      return false;
    }

    return true;
  }

  void createOrUpdateMenu() async {
    if (!await validateForm()) return;

    if (editMode.value) {
      final result = await ProductsRepository.updateProduct(
        id: menu.value!.id,
        name: nameController.text,
        price: priceController.text,
        description: descriptionController.text,
        categoryId: categorySelected.value,
        imageFile: imageFile.value != null ? File(imageFile.value!.path) : null,
        isOnline: isOnline.value,
        isActive: isActive.value,
        stock: stockController.text.isEmpty ? '0' : stockController.text,
        variant: listSelectedVariant,
      );

      if (result) {
        Get.back();
        showSnackbar("Success", "Produk berhasil diperbarui");
      } else {
        showSnackbar("Error", "Gagal memperbarui produk");
      }
    } else {
      final result = await ProductsRepository.createProduct(
        name: nameController.text,
        price: priceController.text,
        description: descriptionController.text,
        categoryId: categorySelected.value,
        imageFile: imageFile.value != null ? File(imageFile.value!.path) : null,
        isOnline: isOnline.value,
        isActive: isActive.value,
        stock: stockController.text.isEmpty ? '0' : stockController.text,
        variant: listSelectedVariant,
      );

      if (result) {
        Get.back();
        showSnackbar("Success", "Produk berhasil ditambahkan");
      } else {
        showSnackbar("Error", "Gagal menambahkan produk");
      }
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
    if (Get.arguments != null) {
      menu.value = Get.arguments['menu'] as Menu;
      editMode.value = true;
      nameController.text = menu.value!.name;
      priceController.text = menu.value!.price.toString();
      descriptionController.text = menu.value!.description;
      stockController.text = menu.value!.stock.toString();
      isActive.value = menu.value!.isActive == 1 ? true : false;
      isOnline.value = menu.value!.isOnline == 1 ? true : false;
      categorySelected.value = menu.value!.category.id;
      listSelectedVariant
          .addAll(menu.value!.variantsElement.map((e) => e.variant));
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
