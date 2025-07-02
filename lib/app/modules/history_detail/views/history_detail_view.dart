import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pos_getx/app/utils/rupiah_formater.dart';

import '../controllers/history_detail_controller.dart';

class HistoryDetailView extends GetView<HistoryDetailController> {
  const HistoryDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        title: Obx(() => Text(
              '${controller.transaction.value.orderNumber} - ${controller.transaction.value.customerName}',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            )),
        centerTitle: true,
        backgroundColor: const Color(0xff121212),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      final transaction = controller.transaction.value;
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff121212),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white),
                        ),
                        padding: const EdgeInsets.all(10),
                        width: Get.width * 0.4,
                        child: Table(
                          columnWidths: const {
                            0: FlexColumnWidth(1.5), // Label
                            1: FlexColumnWidth(0.2), // Separator ":"
                            2: FlexColumnWidth(4), // Value
                          },
                          children: [
                            _buildRow('Order Number', transaction.orderNumber),
                            _buildRow(
                                'Order Date', transaction.orderDate.toString()),
                            _buildRow(
                                'Customer Name', transaction.customerName),
                            _buildRow('Table Number',
                                transaction.tableNumber.toString()),
                            _buildRow('Sub Total',
                                formatRupiah(transaction.subTotal)),
                            _buildRow(
                                'Discount', formatRupiah(transaction.discount)),
                            _buildRow('Total', formatRupiah(transaction.total)),
                          ],
                        ),
                      );
                    }),
                    Obx(() {
                      final transaction = controller.transaction.value;
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xff121212),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white),
                        ),
                        width: Get.width * 0.4,
                        child: Table(
                          columnWidths: const {
                            0: FlexColumnWidth(1.5), // Label
                            1: FlexColumnWidth(0.2), // Separator ":"
                            2: FlexColumnWidth(4), // Value
                          },
                          children: [
                            _buildRow(
                                'Payment Method', transaction.paymentMethod),
                            _buildRow('Total', formatRupiah(transaction.total)),
                            _buildRow(
                                'Cash',
                                transaction.cash != null
                                    ? formatRupiah(transaction.cash!)
                                    : 'N/A'),
                            _buildRow(
                                'Change',
                                transaction.change != null
                                    ? formatRupiah(transaction.change!)
                                    : 'N/A'),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Order Items',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Obx(() {
                    final items = controller.transaction.value.data;
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Card(
                          color: const Color(0xff1e1e1e),
                          child: ListTile(
                            title: Text(item.menu,
                                style: const TextStyle(color: Colors.white)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Quantity: ${item.quantity}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'Base Price: ${formatRupiah(item.basePrice)}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'Variant Price: ${formatRupiah(item.variantPrice)}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'Total Price: ${formatRupiah(item.totalPrice)}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                ...item.variants.map((variant) => Text(
                                      '${variant.variantName}  ${variant.name}: ${formatRupiah(variant.price)}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )),
                              ],
                            ),
                            trailing: Text(
                              'Total: ${formatRupiah(item.totalPrice)}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text(
                          'Close',
                          style: TextStyle(color: Colors.white),
                        )),
                    ElevatedButton(
                      onPressed: () {
                        controller.printReceipt();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Print',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Obx(() => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}

TableRow _buildRow(String label, String value) {
  return TableRow(children: [
    Text(label, style: const TextStyle(color: Colors.white)),
    const Text(":", style: TextStyle(color: Colors.white)),
    Text(value, style: const TextStyle(color: Colors.white)),
  ]);
}
