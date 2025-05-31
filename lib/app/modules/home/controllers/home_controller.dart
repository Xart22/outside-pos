import 'package:get/get.dart';
import 'package:pos_getx/app/service/global_state.dart';

class HomeController extends GetxController {
  final pageIndex = "Casier".obs;
  final globalState = Get.find<GlobalState>();
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
