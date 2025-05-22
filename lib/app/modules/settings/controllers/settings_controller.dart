import 'package:get/get.dart';

class SettingsController extends GetxController {
  final pageIndex = "Casier".obs;
  void changePage(String index) {
    pageIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
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
