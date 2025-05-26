import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final tesCategori = [
    Tab(
      text: 'All',
      icon: const Icon(Icons.all_inclusive),
    ),
    Tab(
      text: 'Food',
      icon: const Icon(Icons.fastfood),
    ),
    Tab(
      text: 'Drink',
      icon: const Icon(Icons.local_drink),
    ),
    Tab(
      text: 'Dessert',
      icon: const Icon(Icons.cake),
    ),
    Tab(
      text: 'Snack',
      icon: const Icon(Icons.local_pizza),
    ),
    Tab(
      text: 'Other',
      icon: const Icon(Icons.category),
    ),
  ];
  final listTab = [].obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    listTab.value = tesCategori;
    tabController = TabController(length: listTab.length, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
