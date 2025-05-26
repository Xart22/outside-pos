import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_getx/app/modules/settings/controllers/settings_controller.dart';
import 'package:pos_getx/app/widgets/Input_field.dart';

class StoreView extends GetView<SettingsController> {
  const StoreView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => InputField(
                label: "Nama Toko",
                hint: "Masukkan nama toko Anda",
                controller: controller.storeNameController,
                textInputAction: TextInputAction.next,
                errorText: controller.nameError.value.isNotEmpty
                    ? controller.nameError.value
                    : null,
              )),
          const SizedBox(height: 16),
          Obx(() => InputField(
                label: "Alamat Toko",
                hint: "Masukkan alamat toko Anda",
                controller: controller.storeAddressController,
                textInputAction: TextInputAction.next,
                errorText: controller.addressError.value.isNotEmpty
                    ? controller.addressError.value
                    : null,
              )),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              controller.saveSettings();
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }
}
