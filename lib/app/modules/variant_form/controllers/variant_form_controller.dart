import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_getx/app/data/model/variant_model.dart';
import 'package:pos_getx/app/data/repository/variants_repository.dart';
import 'package:pos_getx/app/utils/rupiah_formater.dart';
import 'package:pos_getx/app/widgets/Input_field.dart';
import 'package:pos_getx/app/widgets/snackbar.dart';

class VariantFormController extends GetxController {
  final nameController = TextEditingController();
  final optionsController = TextEditingController();
  final priceController = TextEditingController();
  final rulesMinController = false.obs;
  final rulesMaxController = false.obs;
  final rulesMin = TextEditingController();

  final formChange = false.obs;
  final listOption = <Option>[].obs;
  final editMode = false.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  void showModalOption() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xff1A1A1A),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
              controller: optionsController,
              label: 'Option Variant',
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10),
            InputField(
              controller: priceController,
              keyboardType: TextInputType.number,
              label: 'Harga Variant',
              textInputAction: TextInputAction.done,
              inputFormatters: [
                CurrencyInputFormatter(),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (optionsController.text.isNotEmpty &&
                        priceController.text.isNotEmpty &&
                        listOption.firstWhereOrNull((option) =>
                                option.name.toLowerCase() ==
                                optionsController.text.toLowerCase()) ==
                            null) {
                      listOption.add(Option(
                        name: optionsController.text,
                        price: int.parse(priceController.text
                            .replaceAll(RegExp(r'[^\d]'), '')),
                        variantId: listOption.isNotEmpty
                            ? listOption.first.variantId
                            : 0,
                        position: listOption.length + 1,
                      ));
                      formChange.value = true;
                      optionsController.clear();
                      priceController.clear();
                      Get.back();
                    } else {
                      showSnackbar("Error",
                          "Nama dan harga tidak boleh kosong atau sudah ada");
                      return;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1A1A1A),
                  ),
                  child: const Text('Simpan'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    clearForm();
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1A1A1A),
                  ),
                  child: const Text('Batal'),
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      isDismissible: false,
    );
  }

  void clearForm() {
    optionsController.clear();
    priceController.clear();
  }

  void saveVariant() {
    if (nameController.text.isEmpty) {
      errorMessage.value = "Nama variant tidak boleh kosong";
      return;
    }
    if (listOption.isEmpty) {
      showSnackbar("Error", "Pilihan variant tidak boleh kosong");
      return;
    }
    final variant = Variant(
      id: editMode.value ? listOption.first.variantId : 0,
      name: nameController.text,
      rulesMin: rulesMinController.value ? 1 : 0,
      rulesMax: rulesMin.text.isNotEmpty ? int.parse(rulesMin.text) : 1,
      options: listOption.toList(),
    );

    isLoading.value = true;
    if (editMode.value) {
      final result = VariantsRepository.updateVariant(variant);
      result.then((success) {
        isLoading.value = false;
        if (success) {
          Get.back(result: true);
          showSnackbar("Sukses", "Variant berhasil disimpan");
        } else {
          showSnackbar("Error", "Gagal menyimpan variant");
        }
      }).catchError((error) {
        isLoading.value = false;
        showSnackbar("Error", error.toString());
      });
    } else {
      final result = VariantsRepository.createVariant(variant);
      result.then((success) {
        isLoading.value = false;
        if (success) {
          Get.back(result: true);
          showSnackbar("Sukses", "Variant berhasil disimpan");
        } else {
          showSnackbar("Error", "Gagal menyimpan variant");
        }
      }).catchError((error) {
        isLoading.value = false;
        showSnackbar("Error", error.toString());
      });
    }
  }

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      if (args['variant'] != null && args['variant'] is Variant) {
        final variant = args['variant'] as Variant;
        nameController.text = variant.name;
        listOption.assignAll(variant.options);
        rulesMinController.value = variant.rulesMin > 0;
        rulesMaxController.value = variant.rulesMax > 1;
        rulesMin.text = variant.rulesMax.toString();
      }
      if (args['isEdit'] != null && args['isEdit'] is bool) {
        editMode.value = args['isEdit'];
      }
    }
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
