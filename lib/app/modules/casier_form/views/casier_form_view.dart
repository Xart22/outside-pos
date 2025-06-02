import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pos_getx/app/style/app_colors.dart';
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
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xff121212),
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                "Product Name $index",
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "Price: \$${(index + 1) * 10}",
                style: const TextStyle(color: Colors.white70),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.green),
                onPressed: () {
                  // Implement the action for the button
                  Get.snackbar(
                      "Added to Cart", "Product Name $index added to cart");
                },
              ),
            ),
          );
        },
        itemCount: 12,
      ),
      bottomNavigationBar: Container(
        height: Get.height * 0.2,
        padding: const EdgeInsets.all(10),
        color: AppColors.primary,
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
                  // Implement the action for the button
                  Get.back();
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
}
