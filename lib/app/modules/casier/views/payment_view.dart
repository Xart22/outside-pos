import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_getx/app/style/app_colors.dart';
import 'package:pos_getx/app/utils/rupiah_formater.dart';

import 'package:pos_getx/app/widgets/input_field.dart';
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
                    activeThumbColor: Colors.green,
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
        const SizedBox(height: 5),
        Obx(() => controller.isDineIn.value
            ? InputField(
                label: "Table Number",
                controller: controller.tableNumberController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
              )
            : const SizedBox.shrink()),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          decoration: BoxDecoration(
            color: const Color(0xff1A1A1A),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white12),
          ),
          child: const Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  "Item",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  "Qty",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "Price",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
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
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          margin: const EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            color: const Color(0xff171717),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sub Total",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Obx(() => Text(
                        formatRupiah(controller.subTotal.value),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Obx(() => Text(
                        formatRupiah(controller.subTotal.value -
                            controller.totalDiscount.value),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: Get.width,
          child: Obx(() => ElevatedButton(
                onPressed: controller.listCart.isEmpty ||
                        controller.globalState.isLoading.value
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
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: controller.globalState.isLoading.value
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white24,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
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
                  formatRupiah(controller.calculatePriceItem(cartItem)),
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 13,
                  ),
                ),
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
                        '${variant.variant.name}: ${optionValue.name}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: controller.globalState.isLoading.value
                          ? null
                          : () {
                              if (cartItem.qty.value > 1) {
                                cartItem.qty.value--;
                                controller.calculateTotalPrice();
                              }
                            },
                      icon: const Icon(Icons.remove_circle_outline,
                          color: Colors.white),
                    ),
                    Container(
                      width: 42,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xff212121),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Text(
                        cartItem.qty.value.toString(),
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                    IconButton(
                      onPressed: controller.globalState.isLoading.value
                          ? null
                          : () {
                              cartItem.qty.value++;
                              controller.calculateTotalPrice();
                            },
                      icon: const Icon(Icons.add_circle_outline,
                          color: Colors.white),
                    ),
                  ],
                )),
          ),
          Expanded(
            flex: 3,
            child: Obx(() => Column(
                  children: [
                    Text(
                      formatRupiah(controller.calculatePriceItem(cartItem) *
                          cartItem.qty.value),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: controller.globalState.isLoading.value
                          ? null
                          : () {
                              controller.listCart.removeAt(index);
                              controller.calculateTotalPrice();
                            },
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
