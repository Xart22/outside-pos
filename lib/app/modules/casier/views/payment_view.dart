import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:pos_getx/app/style/app_colors.dart';
import 'package:pos_getx/app/utils/rupiah_formater.dart';
import 'package:pos_getx/app/utils/url_image.dart';
import 'package:pos_getx/app/widgets/Input_field.dart';
import 'package:pos_getx/app/widgets/snackbar.dart';

import '../controllers/casier_controller.dart';

class PaymentView extends GetView<CasierController> {
  const PaymentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Order #12345",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(height: 5),
        Text("Order Type",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Dine In",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )),
            Obx(() => Switch(
                  value: controller.isDineIn.value,
                  onChanged: (value) {
                    controller.isDineIn.value = value;
                    if (value) {
                      controller.customerTableController.clear();
                    }
                  },
                  activeColor: Colors.green,
                )),
          ],
        ),
        InputField(
            label: "Customer Name",
            controller: controller.customerNameController,
            textInputAction: TextInputAction.next),
        const SizedBox(height: 5),
        Obx(() => controller.isDineIn.value
            ? InputField(
                label: "Customer Table",
                controller: controller.customerTableController,
                textInputAction: TextInputAction.done,
              )
            : const SizedBox.shrink()),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Item",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(width: 30),
            Text("Qty",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
            Text("Price",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
        SizedBox(
          height: Get.height * 0.35,
          child: Obx(() => ListView.builder(
                shrinkWrap: true,
                itemCount: controller.listCart.length,
                itemBuilder: (context, index) {
                  return cartItemWidget(
                    index,
                  );
                },
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Sub Total",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
            Obx(() => Text('${formatRupiah(controller.totalPrice.value)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
            Obx(() => Text('${formatRupiah(controller.totalPrice.value)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ))),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: Get.width,
          child: Obx(() => ElevatedButton(
                onPressed: controller.listCart.isEmpty
                    ? null
                    : () {
                        if (controller.customerNameController.text.isEmpty) {
                          showSnackbar(
                              'Error', 'Customer name cannot be empty');
                          return;
                        }
                        if (controller.isDineIn.value &&
                            controller.customerTableController.text.isEmpty) {
                          showSnackbar(
                              'Error', 'Customer table cannot be empty');
                          return;
                        }
                        controller.paymentModal();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: const Color(0xffBDBDBD),
                ),
                child: const Text(
                  'Process Payment',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              )),
        ),
      ],
    );
  }

  Widget cartItemWidget(
    int index,
  ) {
    final cartItem = controller.listCart[index];
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white24,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: CachedNetworkImageProvider(imageUrl(controller
                    .listMenu
                    .firstWhere((menu) => menu.id == cartItem.menuId)
                    .image)),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: Get.width * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.listMenu
                          .firstWhere((menu) => menu.id == cartItem.menuId)
                          .name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                        '${formatRupiah(controller.calculatePriceItem(cartItem))}',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 14,
                        )),
                    if (cartItem.options.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: cartItem.options.entries.map((option) {
                          final variant = controller.listMenu
                              .firstWhere((menu) => menu.id == cartItem.menuId)
                              .variantsElement
                              .firstWhere((v) => v.variant.id == option.key);
                          final optionValue = variant.variant.options
                              .firstWhere((o) => o.id == option.value);
                          return Text(
                            '${variant.variant.name}\n${optionValue.name}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 40,
            child: Obx(() => TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  controller:
                      TextEditingController(text: cartItem.qty.value.toString())
                        ..selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: cartItem.qty.value.toString().length),
                        ),
                  onChanged: (value) {
                    cartItem.qty.value = int.tryParse(value) ?? 1;
                    controller.calculateTotalPrice();
                  },
                )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Text(
                  '${formatRupiah(controller.calculatePriceItem(cartItem) * cartItem.qty.value)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ))),
              IconButton(
                onPressed: () {
                  controller.listCart.removeAt(index);
                  controller.calculateTotalPrice();
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
