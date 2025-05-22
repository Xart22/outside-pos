import 'package:get/get.dart';

class HomeController extends GetxController {
  final pageIndex = "User".obs;
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

  void changePage(String index) {
    pageIndex.value = index;
  }
}
