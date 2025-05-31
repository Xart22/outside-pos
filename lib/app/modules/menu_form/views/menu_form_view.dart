import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_getx/app/style/app_colors.dart';
import 'package:pos_getx/app/utils/rupiah_formater.dart';
import 'package:pos_getx/app/utils/url_image.dart';
import 'package:pos_getx/app/widgets/Input_field.dart';
import 'package:pos_getx/app/widgets/select_search.dart';

import '../controllers/menu_form_controller.dart';

class MenuFormView extends GetView<MenuFormController> {
  const MenuFormView({super.key});
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
          // Obx(() => controller.formChange.value
          //     ? IconButton(
          //         icon: const Icon(Icons.save, color: Colors.white),
          //         onPressed: () {
          //           controller.saveVariant();
          //         },
          //       )
          //     : const SizedBox.shrink()),
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
                  Obx(
                    () => InputField(
                      label: "Nama Produk",
                      hint: "Masukkan nama produk",
                      controller: controller.nameController,
                      textInputAction: TextInputAction.next,
                      errorText: controller.nameError.value.isNotEmpty
                          ? controller.nameError.value
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => InputField(
                      label: "Harga",
                      hint: "Masukkan harga produk",
                      controller: controller.priceController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      errorText: controller.priceError.value.isNotEmpty
                          ? controller.priceError.value
                          : null,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => InputField(
                      label: "Deskripsi",
                      hint: "Masukkan deskripsi produk",
                      controller: controller.descriptionController,
                      textInputAction: TextInputAction.next,
                      errorText: controller.descriptionError.value.isNotEmpty
                          ? controller.descriptionError.value
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => InputField(
                      label: "Stok",
                      hint: "Masukkan stok produk",
                      controller: controller.stockController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      errorText: controller.stockError.value.isNotEmpty
                          ? controller.stockError.value
                          : null,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SelectSearch(
                    label: "Kategori",
                    data: controller.listCategories,
                    selectedItem: controller.listCategories.firstWhereOrNull(
                        (e) => e.id == controller.categorySelected.value),
                    onChanged: (value) {
                      if (value != null) {
                        controller.categorySelected.value = value;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Aktif',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Switch(
                          value: controller.isActive.value,
                          onChanged: (value) {
                            controller.isActive.value = value;
                          },
                          activeColor: Colors.green,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Online',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Switch(
                          value: controller.isOnline.value,
                          onChanged: (value) {
                            controller.isOnline.value = value;
                          },
                          activeColor: Colors.green,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: controller.menu.value != null
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    children: [
                      controller.menu.value?.image != null
                          ? Container(
                              width: Get.width / 4.5,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade800,
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(imageUrl(
                                      controller.menu.value?.image ?? '')),
                                ),
                              ),
                            )
                          : SizedBox(),
                      const SizedBox(width: 8),
                      Obx(() => GestureDetector(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? pickedFile = await picker.pickImage(
                                source: ImageSource.gallery,
                                maxWidth: 800,
                                maxHeight: 800,
                              );
                              if (pickedFile != null) {
                                controller.imageFile.value = pickedFile;
                              }
                            },
                            child: Container(
                              width: Get.width / 4.5,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade800,
                                borderRadius: BorderRadius.circular(8),
                                image: controller.imageFile.value != null
                                    ? DecorationImage(
                                        image: FileImage(
                                          controller.imageFile.value?.path !=
                                                  null
                                              ? File(controller
                                                  .imageFile.value!.path)
                                              : File(''),
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: controller.imageFile.value == null
                                  ? Center(
                                      child: Text(
                                        controller.menu.value?.image != null
                                            ? 'Ganti Foto Produk'
                                            : 'Pilih Foto Produk',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  : null,
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Pilihan Variant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() => SizedBox(
                        child: ReorderableListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.listSelectedVariant.length,
                          onReorder: (oldIndex, newIndex) {
                            if (newIndex > oldIndex) newIndex--;
                            final item = controller.listSelectedVariant
                                .removeAt(oldIndex);
                            controller.listSelectedVariant
                                .insert(newIndex, item);
                          },
                          itemBuilder: (context, index) {
                            final option =
                                controller.listSelectedVariant[index];
                            return Card(
                              key: ValueKey(option.name),
                              color: const Color(0xff2c2c2c),
                              child: ListTile(
                                key: ValueKey(option.name),
                                title: Text(
                                  option.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    controller.listSelectedVariant
                                        .removeAt(index);
                                  },
                                ),
                                onTap: () => {},
                              ),
                            );
                          },
                        ),
                      )),
                  TextButton(
                    onPressed: () {
                      controller.showVariantDialog();
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Simpan',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
