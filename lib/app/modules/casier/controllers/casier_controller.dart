import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pos_getx/app/data/model/categories_model.dart';
import 'package:pos_getx/app/data/model/menu_model.dart';
import 'package:pos_getx/app/data/repository/categories_repository.dart';
import 'package:pos_getx/app/data/repository/products_repository.dart';

class CasierController extends GetxController with GetTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  final today = "".obs;
  final listMenu = <Menu>[].obs;
  final filteredMenu = <Menu>[].obs;
  final listCategories = <Category>[].obs;
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
  void getAllData() async {
    listMenu.value = await ProductsRepository.getProducts();
    filteredMenu.value = listMenu;

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

  void searchMenu(String query) {
    if (query.isEmpty) {
      filteredMenu.value = listMenu;
    } else {
      filteredMenu.value = listMenu
          .where(
              (menu) => menu.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: listTab.length, vsync: this);
    getAllData();
    initializeDateFormatting();
    DateTime now = DateTime.now();
    today.value = DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(now);
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
