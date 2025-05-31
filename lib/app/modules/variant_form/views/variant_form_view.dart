import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pos_getx/app/style/app_colors.dart';
import 'package:pos_getx/app/widgets/Input_field.dart';
import 'package:pos_getx/app/widgets/loading.dart';

import '../controllers/variant_form_controller.dart';

class VariantFormView extends GetView<VariantFormController> {
  const VariantFormView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1A1A1A),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Obx(() => Text(
              controller.editMode.value ? 'Edit Variant' : 'Tambah Variant',
              style: const TextStyle(color: Colors.white),
            )),
        actions: [
          Obx(() => controller.formChange.value
              ? IconButton(
                  icon: const Icon(Icons.save, color: Colors.white),
                  onPressed: () {
                    controller.saveVariant();
                  },
                )
              : const SizedBox.shrink()),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff121212),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detail Variant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(() => InputField(
                        label: 'Nama Variant',
                        controller: controller.nameController,
                        textInputAction: TextInputAction.next,
                        errorText: controller.errorMessage.value.isNotEmpty
                            ? controller.errorMessage.value
                            : null,
                        onTap: () => controller.errorMessage.value = '',
                      )),
                  const SizedBox(height: 20),
                  Text(
                    'Apa variant ini wajib dipilih?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() => Row(
                        children: [
                          const Text(
                            'Ya',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Radio<bool>(
                            value: true,
                            groupValue: controller.rulesMinController.value,
                            onChanged: (value) {
                              controller.rulesMinController.value = value!;
                            },
                          ),
                          const Text(
                            'Tidak',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Radio<bool>(
                            value: false,
                            groupValue: controller.rulesMinController.value,
                            onChanged: (value) {
                              controller.rulesMinController.value = value!;
                            },
                          ),
                        ],
                      )),
                  const SizedBox(height: 20),
                  Text(
                    'Ada batasan jumlah pilihan variant?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() => Row(
                        children: [
                          const Text(
                            'Ya',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Radio<bool>(
                            value: true,
                            groupValue: controller.rulesMaxController.value,
                            onChanged: (value) {
                              controller.rulesMaxController.value = value!;
                              controller.rulesMin.text = '1';
                            },
                          ),
                          const Text(
                            'Tidak',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Radio<bool>(
                            value: false,
                            groupValue: controller.rulesMaxController.value,
                            onChanged: (value) {
                              controller.rulesMaxController.value = value!;
                              if (value == false) {
                                controller.rulesMin.text = '1';
                                controller.errorMessage.value = '';
                              }
                            },
                          ),
                        ],
                      )),
                  const SizedBox(height: 20),
                  Obx(() => controller.rulesMaxController.value
                      ? InputField(
                          label: 'Batasan jumlah pilihan variant',
                          controller: controller.rulesMin,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          errorText: controller.errorMessage.value.isNotEmpty
                              ? controller.errorMessage.value
                              : null,
                          onTap: () => controller.errorMessage.value = '',
                        )
                      : const SizedBox.shrink()),
                  const SizedBox(height: 20),
                  Text(
                    'Pilihan Variant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() => SizedBox(
                        height: 220,
                        child: ReorderableListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.listOption.length,
                          onReorder: (oldIndex, newIndex) {
                            if (newIndex > oldIndex) newIndex--;
                            final item =
                                controller.listOption.removeAt(oldIndex);
                            controller.listOption.insert(newIndex, item);
                            controller.listOption[newIndex].position = newIndex;
                            controller.formChange.value = true;
                          },
                          itemBuilder: (context, index) {
                            final option = controller.listOption[index];
                            return Card(
                              key: ValueKey(option.name),
                              color: const Color(0xff2c2c2c),
                              child: ListTile(
                                key: ValueKey(option.name),
                                title: Text(
                                  option.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () {
                                        controller.listOption.removeAt(index);
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white70,
                                    ),
                                  ],
                                ),
                                onTap: () => {
                                  controller.showModalOption(),
                                  controller.optionsController.text =
                                      option.name,
                                  controller.priceController.text =
                                      "Rp. ${option.price.toString()}",
                                },
                              ),
                            );
                          },
                        ),
                      )),
                  TextButton(
                    onPressed: () {
                      controller.clearForm();
                      controller.showModalOption();
                    },
                    child: const Text(
                      'Tambah Pilihan Variant',
                      style: TextStyle(color: AppColors.primary, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          controller.saveVariant();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        child: const Text(
                          'Simpan Variant',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Obx(
              () => controller.isLoading.value
                  ? Container(
                      color: Colors.white.withValues(alpha: 0.5),
                      child: const Center(
                        child: Loading(size: 50),
                      ),
                    )
                  : const SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }
}
