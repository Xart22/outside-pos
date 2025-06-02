import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos_getx/app/data/model/menu_model.dart';
import 'package:pos_getx/app/data/model/variant_model.dart';
import 'package:pos_getx/app/style/app_colors.dart';
import 'package:pos_getx/app/widgets/Input_field.dart';
import '../controllers/casier_form_controller.dart';

class CasierFormView extends GetView<CasierFormController> {
  const CasierFormView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1A1A1A),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Customize Produk",
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff121212),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(children: [
              ...controller.menu.variantsElement
                  .map((variantEl) => buildVariantItem(variantEl)),
              InputField(
                label: 'Note',
                controller: controller.noteController,
                maxLines: 3,
                textInputAction: TextInputAction.done,
              )
            ])),
      ),
      bottomNavigationBar: Container(
        height: Get.height * 0.2,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Item Quantity",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                quantityField(),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  controller.addToCart();
                },
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget quantityField() {
    return Row(
      children: [
        IconButton(
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: const BorderSide(color: Colors.white, width: 1),
            ),
          ),
          onPressed: () {
            int currentValue =
                int.tryParse(controller.quantityController.text) ?? 0;
            if (currentValue > 1) {
              controller.quantityController.text =
                  (currentValue - 1).toString();
            }
          },
          icon: const Icon(Icons.remove, color: Colors.white),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 50,
          child: TextFormField(
            controller: controller.quantityController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: "0",
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: const BorderSide(color: Colors.white, width: 1),
            ),
          ),
          onPressed: () {
            int currentValue =
                int.tryParse(controller.quantityController.text) ?? 0;
            controller.quantityController.text = (currentValue + 1).toString();
          },
          icon: const Icon(Icons.add, color: Colors.white),
        ),
      ],
    );
  }

  Widget buildVariantItem(VariantElement variantEl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(variantEl.variant.name,
            style: const TextStyle(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 10),
        Column(
          children: variantEl.variant.options
              .map((option) => buildOptionItem(option, variantEl.variant.id))
              .toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildOptionItem(Option option, int variantId) {
    return Obx(() {
      final selectedOptionId = controller.selectedOptions[variantId];
      return RadioListTile<int>(
        title: Text(
          '${option.name} (+${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ').format(option.price)})',
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        value: option.id!,
        groupValue: selectedOptionId,
        onChanged: (int? value) {
          if (value != null) {
            controller.selectedOptions[variantId] = value;
          }
        },
        activeColor: Colors.white,
        tileColor: Colors.transparent,
        selected: selectedOptionId == option.id,
      );
    });
  }
}
