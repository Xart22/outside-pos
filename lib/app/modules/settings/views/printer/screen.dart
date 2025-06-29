import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_getx/app/modules/settings/controllers/settings_controller.dart';

class ManagePrinterView extends GetView<SettingsController> {
  const ManagePrinterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              controller.printReceipt(controller.macPrinterKitchen);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Test Printer Kitchen",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.printReceipt(controller.macPrinterCasier);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Test Printer Casier",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
