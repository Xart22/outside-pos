import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_getx/app/data/model/categories_model.dart';
import 'package:pos_getx/app/data/model/menu_model.dart';
import 'package:pos_getx/app/data/model/variant_model.dart';
import 'package:pos_getx/app/data/repository/categories_repository.dart';
import 'package:pos_getx/app/data/repository/variants_repository.dart';
import 'package:pos_getx/app/style/app_colors.dart';

class MenuFormController extends GetxController {
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  final nameError = ''.obs;
  final priceError = ''.obs;
  final descriptionError = ''.obs;
  final categorySelected = 0.obs;
  final stockError = ''.obs;
  final isActive = false.obs;
  final isOnline = false.obs;
  final listCategories = <Category>[].obs;
  final listVariant = <Variant>[].obs;
  final listSelectedVariant = <Variant>[].obs;
  final imageFile = Rx<XFile?>(null);
  final menu = Rx<Menu?>(null);

  final editMode = false.obs;

  void getData() async {
    listCategories.value = await CategoriesRepository.getCategories();
    listVariant.value = await VariantsRepository.getVariants();
  }

  void showVariantDialog() {
    Get.defaultDialog(
      title: 'Pilih Variants',
      backgroundColor: const Color.fromARGB(255, 52, 52, 52),
      titleStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      content: SizedBox(
        height: 300,
        width: Get.width * 0.8,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: listVariant.length,
          itemBuilder: (context, index) {
            return Obx(() => Card(
                  child: CheckboxListTile(
                    title: Text(listVariant[index].name),
                    value: listSelectedVariant.contains(listVariant[index]),
                    activeColor: AppColors.primary,
                    onChanged: (bool? value) {
                      if (value == true) {
                        listSelectedVariant.add(listVariant[index]);
                      } else {
                        listSelectedVariant.remove(listVariant[index]);
                      }
                    },
                  ),
                ));
          },
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () => Get.back(),
        child: Text('OK'),
      ),
    );
  }

  @override
  void onInit() {
    getData();
    super.onInit();
    if (Get.arguments != null) {
      menu.value = Get.arguments['menu'] as Menu;
      editMode.value = true;
      nameController.text = menu.value!.name;
      priceController.text = menu.value!.price.toString();
      descriptionController.text = menu.value!.description ?? '';
      stockController.text = menu.value!.stock.toString();
      isActive.value = menu.value!.isActive == 1 ? true : false;
      isOnline.value = menu.value!.isOnline == 1 ? true : false;
      categorySelected.value = menu.value!.category.id;
      listSelectedVariant.addAll(menu.value!.variants.map((e) => e.variant));
    }
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
