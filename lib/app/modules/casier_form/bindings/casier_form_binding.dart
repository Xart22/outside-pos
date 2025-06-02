import 'package:get/get.dart';

import '../controllers/casier_form_controller.dart';

class CasierFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CasierFormController>(
      () => CasierFormController(),
    );
  }
}
