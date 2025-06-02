import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CasierFormController extends GetxController {
  TextEditingController quantityController = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    quantityController.text = "1";
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
