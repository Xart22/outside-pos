import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_getx/app/data/repository/settings_repository.dart';
import 'package:pos_getx/app/service/global_state.dart';
import 'package:pos_getx/app/widgets/snackbar.dart';

class SettingsController extends GetxController {
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeAddressController = TextEditingController();
  final nameError = ''.obs;
  final addressError = ''.obs;
  final globalState = Get.find<GlobalState>();

  final pageIndex = "Manage Store".obs;
  void changePage(String index) {
    pageIndex.value = index;
  }

  void getSettingsData() async {
    final settings = await SettingsRepository.loadSettings();
    if (settings.data.isNotEmpty) {
      storeNameController.text = settings.data
          .firstWhere((element) => element.name == 'Store Name')
          .value;
      storeAddressController.text = settings.data
          .firstWhere((element) => element.name == 'Store Address')
          .value;
    } else {
      storeNameController.text = '';
      storeAddressController.text = '';
    }
  }

  void saveSettings() async {
    if (storeNameController.text.isEmpty &&
        storeAddressController.text.isEmpty) {
      nameError.value = 'Nama Toko tidak boleh kosong';
      addressError.value = 'Alamat Toko tidak boleh kosong';
      return;
    }
    if (storeNameController.text.isEmpty) {
      nameError.value = 'Nama Toko tidak boleh kosong';
      addressError.value = '';
      return;
    }
    if (storeAddressController.text.isEmpty) {
      nameError.value = '';
      addressError.value = 'Alamat Toko tidak boleh kosong';
      return;
    }
    final settings = [
      {
        'name': 'Store Name',
        'value': storeNameController.text,
      },
      {
        'name': 'Store Address',
        'value': storeAddressController.text,
      },
    ];
    nameError.value = '';
    addressError.value = '';
    globalState.isLoading.value = true;
    final response = await SettingsRepository.updateSettings(settings);
    if (response) {
      showSnackbar('Success', 'Settings updated successfully');
    } else {
      showSnackbar('Error', 'Failed to update settings');
    }
    globalState.isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    getSettingsData();
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
