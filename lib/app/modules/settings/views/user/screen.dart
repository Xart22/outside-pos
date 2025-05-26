import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_getx/app/modules/settings/controllers/settings_controller.dart';
import 'package:pos_getx/app/widgets/Input_field.dart';

class ManageUserView extends GetView<SettingsController> {
  const ManageUserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputField(
            label: "Nama Toko",
            hint: "Masukkan nama toko Anda",
            controller: controller.storeNameController,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),
          InputField(
            label: "Alamat Toko",
            hint: "Masukkan alamat toko Anda",
            controller: controller.storeAddressController,
            textInputAction: TextInputAction.next,
          ),
        ],
      ),
    );
  }
}
