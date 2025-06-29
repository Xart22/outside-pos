import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';

class GlobalState extends GetxService {
  final isLoading = false.obs;
  final bluetoothEnabled = false.obs;
  final bluetoothPermissionGranted = false.obs;

  final kitchenPrinterIsConnected = false.obs;
  final casierPrinterIsConnected = false.obs;

  final macPrinterCasier = '66:32:F9:51:03:BF';
  final macPrinterKitchen = '66:32:A7:E6:BD:A5';

  Future<bool> askPermission() async {
    print('Asking for Bluetooth permission...');

    if (await Permission.bluetoothScan.isGranted &&
        await Permission.bluetoothConnect.isGranted) {
      bluetoothPermissionGranted.value = true;
      return true;
    }

    final statusScan = await Permission.bluetoothScan.request();
    final statusConnect = await Permission.bluetoothConnect.request();
    final statusLocation = await Permission.locationWhenInUse.request();

    print(
        'Scan: $statusScan | Connect: $statusConnect | Location: $statusLocation');

    if (statusScan.isGranted &&
        statusConnect.isGranted &&
        statusLocation.isGranted) {
      bluetoothPermissionGranted.value = true;
      return true;
    } else {
      bluetoothPermissionGranted.value = false;
      return false;
    }
  }

  Future<GlobalState> init() async {
    // Check if Bluetooth is enabled
    await askPermission();

    return this;
  }
}
