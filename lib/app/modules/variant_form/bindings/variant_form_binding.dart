import 'package:get/get.dart';

import '../controllers/variant_form_controller.dart';

class VariantFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VariantFormController>(
      () => VariantFormController(),
    );
  }
}
