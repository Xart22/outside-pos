import 'package:get/get.dart';

import '../controllers/casier_controller.dart';

class CasierBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CasierController>(
      () => CasierController(),
    );
  }
}
