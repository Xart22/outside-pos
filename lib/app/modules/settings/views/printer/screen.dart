import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_getx/app/style/app_colors.dart';
import 'package:pos_getx/app/modules/settings/controllers/settings_controller.dart';

class ManagePrinterView extends GetView<SettingsController> {
  const ManagePrinterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff121212),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pengaturan Printer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton.icon(
                onPressed: controller.globalState.isLoading.value
                    ? null
                    : () {
                        controller.printReceipt(controller.macPrinterKitchen);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: const Color(0xff8A8A8A),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.print, color: Colors.white),
                label: const Text(
                  "Test Printer Kitchen",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton.icon(
                onPressed: controller.globalState.isLoading.value
                    ? null
                    : () {
                        controller.printReceipt(controller.macPrinterCasier);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonLight,
                  disabledBackgroundColor: const Color(0xff8A8A8A),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.print_outlined, color: Colors.white),
                label: const Text(
                  "Test Printer Kasir",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
