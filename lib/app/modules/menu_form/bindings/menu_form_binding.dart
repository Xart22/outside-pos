import 'package:get/get.dart';

import '../controllers/menu_form_controller.dart';

class MenuFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuFormController>(
      () => MenuFormController(),
    );
  }
}
