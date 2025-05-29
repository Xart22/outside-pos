import 'package:get/get.dart';

import '../controllers/variants_controller.dart';

class VariantsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VariantsController>(
      () => VariantsController(),
    );
  }
}
