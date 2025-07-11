import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:pos_getx/app/style/app_colors.dart';
import 'package:pos_getx/app/utils/rupiah_formater.dart';

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
        Obx(() => Text(controller.orderNumber.value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ))),
        const SizedBox(height: 5),
        Text("Order Type",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Dine In",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
            SizedBox(
              height: 10,
              child: Obx(() => Switch(
                    value: controller.isDineIn.value,
                    onChanged: (value) {
                      controller.isDineIn.value = value;
                    },
                    activeColor: Colors.green,
                  )),
            ),
          ],
        ),
        InputField(
          label: "Customer Name",
          controller: controller.customerNameController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
        ),
        Obx(() => controller.isDineIn.value
            ? InputField(
                label: "Table Number",
                controller: controller.tableNumberController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
              )
            : const SizedBox.shrink()),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Item",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(width: 150),
            Text("Qty",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(width: 70),
            Text("Price",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
        SizedBox(
          height: Get.height * 0.44,
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
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
            Obx(() => Text('${formatRupiah(controller.subTotal.value)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
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
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                )),
            Obx(() => Text(
                '${formatRupiah(controller.subTotal.value - controller.totalDiscount.value)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ))),
          ],
        ),
        const SizedBox(height: 5),
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
                            controller.tableNumberController.text.isEmpty) {
                          showSnackbar('Error', 'Table number cannot be empty');
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
                  style: TextStyle(fontSize: 12, color: Colors.white),
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
              SizedBox(
                width: 80,
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
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  cartItem.qty.value++;
                  controller.calculateTotalPrice();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: const CircleBorder(),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 16),
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
                      controller: TextEditingController(
                          text: cartItem.qty.value.toString())
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
              ElevatedButton(
                onPressed: () {
                  if (cartItem.qty.value > 1) {
                    cartItem.qty.value--;
                    controller.calculateTotalPrice();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: const CircleBorder(),
                ),
                child: const Icon(Icons.remove, color: Colors.white, size: 16),
              ),
            ],
          ),
          Expanded(
            child: Column(
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
          ),
        ],
      ),
    );
  }
}
