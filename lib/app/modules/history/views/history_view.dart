import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pos_getx/app/utils/rupiah_formater.dart';
import 'package:pos_getx/app/widgets/search.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 32, 32, 32),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              width: Get.width,
              child: InputTextField(
                controller: controller.searchController,
                hintText: 'Search',
                onChanged: (value) {},
              ),
            ),
            SizedBox(
              height: Get.height * 0.55,
              child: Obx(() => ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = controller.transactions[index];
                      return Card(
                        child: ListTile(
                            title: Text(transaction.orderId),
                            subtitle: Text(
                              'Total: ${formatRupiah(transaction.totalPrice)}',
                            ),
                            trailing: Text(transaction.createdAt
                                .toString()
                                .replaceAll('.000', ' '))),
                      );
                    },
                  )),
            ),
            const SizedBox(height: 10),
            Obx(() => Text(
                  'Total Transactions: ${controller.transactions.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )),
            const SizedBox(height: 10),
            Obx(
              () => Text(
                'Starting Balance: ${formatRupiah(controller.cashDrawerStart.value)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Obx(() => Text(
                  'Total Cash: ${formatRupiah(controller.transactions.fold(0, (sum, item) => item.paymentMethod == 'CASH' ? sum + item.totalPrice : sum))}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )),
            const SizedBox(height: 10),
            Obx(() => Text(
                  'Total Qris: ${formatRupiah(controller.transactions.fold(0, (sum, item) => item.paymentMethod == 'QRIS' ? sum + item.totalPrice : sum))}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )),
            const SizedBox(height: 10),
            Obx(() => Text(
                  'Total Cash Drawer: ${formatRupiah(controller.cashDrawerStart.value + controller.transactions.fold(0, (sum, item) => item.paymentMethod == 'CASH' ? sum + item.totalPrice : sum))}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
