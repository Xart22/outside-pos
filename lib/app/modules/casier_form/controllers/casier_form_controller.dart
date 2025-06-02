import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_getx/app/data/model/cart_model.dart';
import 'package:pos_getx/app/data/model/menu_model.dart';
import 'package:pos_getx/app/widgets/snackbar.dart';

class CasierFormController extends GetxController {
  TextEditingController quantityController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  Menu menu = Get.arguments['menu'];
  final selectedOptions = <int, int>{}.obs;
  final isMinusDisabled = true.obs;

  void addToCart() {
    if (quantityController.text.isEmpty) {
      showSnackbar("Error", "Quantity cannot be empty");
      return;
    }

    int quantity = int.tryParse(quantityController.text) ?? 1;
    if (quantity <= 0) {
      showSnackbar("Error", "Quantity must be greater than 0");
      return;
    }

    for (var variant in menu.variantsElement) {
      if (variant.variant.rulesMax > 0 &&
          selectedOptions[variant.variant.id] == null) {
        showSnackbar(
            "Error", "You must select an option for ${variant.variant.name}");
        return;
      }
      if (selectedOptions[variant.variant.id] != null &&
          selectedOptions[variant.variant.id]! < variant.variant.rulesMin) {
        showSnackbar("Error",
            "You must select at least ${variant.variant.rulesMin} options for ${variant.variant.name}");
        return;
      }
    }

    final CartItem cartItem = CartItem(
      menuId: menu.id,
      qty: quantity.obs,
      options: selectedOptions,
      note: noteController.text,
    );

    Get.back(result: cartItem);
  }

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
}
