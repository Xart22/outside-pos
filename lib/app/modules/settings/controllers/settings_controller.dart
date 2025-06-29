import 'package:flutter/material.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:get/get.dart';
import 'package:pos_getx/app/data/repository/settings_repository.dart';
import 'package:pos_getx/app/service/global_state.dart';
import 'package:pos_getx/app/widgets/snackbar.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class SettingsController extends GetxController {
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeAddressController = TextEditingController();

  final macPrinterCasier = '66:32:F9:51:03:BF';
  final macPrinterKitchen = '66:32:A7:E6:BD:A5';
  final nameError = ''.obs;
  final addressError = ''.obs;
  final globalState = Get.find<GlobalState>();
  final printerConnected = false.obs;

  final pageIndex = "Manage Store".obs;
  void changePage(String index) {
    pageIndex.value = index;
  }

  getSettingsData() async {
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

  Future<void> printReceipt(String macAddress) async {
    var bytes = <int>[];
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    bytes += generator.reset();

    bytes += generator.text('================================');
    bytes += generator.text('TES PRINTER',
        styles: PosStyles(align: PosAlign.center, bold: true));
    bytes += generator.text('================================');
    bytes += generator.feed(3);
    // Generate your receipt bytes here
    await _safePrint(macAddress, bytes);
  }

  Future<void> _safePrint(String macAddress, List<int> bytes) async {
    try {
      await PrintBluetoothThermal.connect(macPrinterAddress: macAddress);

      bool isConnected = await PrintBluetoothThermal.connectionStatus;
      if (isConnected) {
        await PrintBluetoothThermal.writeBytes(bytes);
      } else {
        print("⚠️ Failed to connect to printer: $macAddress");
      }
    } catch (e) {
      print("🛑 Error printing to $macAddress: $e");
    } finally {
      // await PrintBluetoothThermal.disconnect;
    }
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
