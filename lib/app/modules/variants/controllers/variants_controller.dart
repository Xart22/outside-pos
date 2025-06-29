import 'package:get/get.dart';
import 'package:pos_getx/app/data/model/variant_model.dart';
import 'package:pos_getx/app/data/repository/variants_repository.dart';

class VariantsController extends GetxController {
  final variants = <Variant>[].obs;

  getVariants() async {
    final response = await VariantsRepository.getVariants();
    print("Variants: $response");
    variants.assignAll(response);
  }

  @override
  void onInit() {
    super.onInit();
    getVariants();
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
