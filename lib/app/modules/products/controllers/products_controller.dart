import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_getx/app/data/model/categories_model.dart';
import 'package:pos_getx/app/data/model/menu_model.dart';
import 'package:pos_getx/app/data/repository/categories_repository.dart';
import 'package:pos_getx/app/data/repository/products_repository.dart';
import 'package:pos_getx/app/service/global_state.dart';
import 'package:pos_getx/app/style/app_colors.dart';
import 'package:pos_getx/app/utils/rupiah_formater.dart';
import 'package:pos_getx/app/utils/url_image.dart';
import 'package:pos_getx/app/widgets/Input_field.dart';
import 'package:pos_getx/app/widgets/select_search.dart';
import 'package:pos_getx/app/widgets/snackbar.dart';

class ProductsController extends GetxController
    with GetTickerProviderStateMixin {
  final globalState = Get.find<GlobalState>();
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
  TextEditingController categoryController = TextEditingController();
  TextEditingController categoryIconController = TextEditingController();
  final categoryError = ''.obs;
  final iconError = ''.obs;
  final listCategories = <Category>[].obs;
  var imageFile = Rx<XFile?>(null);
  final listMenu = <Menu>[].obs;

  late TabController tabController;

  final listTab = [
    Tab(
      text: 'All',
      icon: Icon(IconData(
        0xe07e,
        fontFamily: 'MaterialIcons',
      )),
    ),
  ].obs;

  void showModalCategory() {
    Get.defaultDialog(
      barrierDismissible: false,
      contentPadding: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
        bottom: 10,
      ),
      backgroundColor: const Color.fromARGB(255, 52, 52, 52),
      title: 'Tambah Kategori',
      titleStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      content: Column(
        children: [
          Obx(() => InputField(
                label: "Nama Category",
                hint: "Masukkan nama category",
                controller: categoryController,
                textInputAction: TextInputAction.next,
                errorText:
                    categoryError.value.isEmpty ? null : categoryError.value,
              )),
          const SizedBox(height: 8),
          Obx(() => InputField(
                label: "Icon",
                hint: "Masukkan icon kategori",
                controller: categoryIconController,
                textInputAction: TextInputAction.next,
                errorText: iconError.value.isEmpty ? null : iconError.value,
              )),
        ],
      ),
      confirm: Obx(() => ElevatedButton(
            onPressed: () {
              if (globalState.isLoading.value) return;
              createCategory();
            },
            child: globalState.isLoading.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2,
                    ),
                  )
                : const Text('Simpan'),
          )),
      cancel: Obx(() => ElevatedButton(
            onPressed: () {
              if (globalState.isLoading.value) return;

              categoryController.clear();
              categoryIconController.clear();
              categoryError.value = '';
              iconError.value = '';
              Get.back();
              Get.back();
            },
            child: globalState.isLoading.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2,
                    ),
                  )
                : const Text('Batal'),
          )),
    );
  }

  void createCategory() async {
    if (categoryController.text.isEmpty &&
        categoryIconController.text.isEmpty) {
      categoryError.value = 'Category tidak boleh kosong';
      iconError.value = 'Icon tidak boleh kosong';
      return;
    }
    if (categoryController.text.isEmpty) {
      categoryError.value = 'Category tidak boleh kosong';
      iconError.value = '';
      return;
    }
    if (categoryIconController.text.isEmpty) {
      categoryError.value = '';
      iconError.value = 'Icon tidak boleh kosong';
      return;
    }
    categoryController.text = categoryController.text.trim();
    if (!RegExp(r'^0x[0-9a-fA-F]+$')
        .hasMatch(categoryIconController.text.trim())) {
      categoryError.value = '';
      iconError.value = 'Icon harus diawali 0x dan berupa kode hexa';
      return;
    }
    categoryError.value = '';
    iconError.value = '';
    globalState.isLoading.value = true;
    await CategoriesRepository.createCategory(
      name: categoryController.text,
      icon: categoryIconController.text,
    ).then((value) {
      globalState.isLoading.value = false;
      if (value) {
        getAllData();
        categoryController.clear();
        categoryIconController.clear();
        Get.back();
        showSnackbar("Success", "Category berhasil ditambahkan");
      } else {
        categoryError.value = 'Category sudah ada';
        showSnackbar("Error", "Category gagal ditambahkan");
      }
    });
  }

  void getAllData() async {
    listMenu.value = await ProductsRepository.getProducts();

    listCategories.value = await CategoriesRepository.getCategories();
    for (var category in listCategories) {
      final exists = listTab.any((tab) => tab.text == category.name);
      if (!exists) {
        listTab.add(
          Tab(
            text: category.name,
            icon: Icon(IconData(
              int.tryParse(category.icon ?? '0xe07e') ?? 0xe07e,
              fontFamily: 'MaterialIcons',
            )),
          ),
        );
      }
    }

    tabController = TabController(length: listTab.length, vsync: this);
    // globalState.isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: listTab.length, vsync: this);
    getAllData();
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
