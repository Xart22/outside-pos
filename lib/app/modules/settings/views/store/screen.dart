import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_getx/app/modules/settings/controllers/settings_controller.dart';
import 'package:pos_getx/app/widgets/input_field.dart';

class StoreView extends GetView<SettingsController> {
  const StoreView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff121212),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pengaturan Toko',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Obx(() => ElevatedButton(
                  onPressed: controller.globalState.isLoading.value
                      ? null
                      : controller.saveSettings,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffEF6C00),
                    disabledBackgroundColor: const Color(0xff8A8A8A),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: controller.globalState.isLoading.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Simpan",
                          style: TextStyle(color: Colors.white),
                        ),
                )),
          ),
        ],
      ),
    );
  }
}
