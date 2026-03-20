import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pos_getx/app/style/app_colors.dart';
import 'package:pos_getx/app/utils/rupiah_formater.dart';
import 'package:pos_getx/app/widgets/loading.dart';

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
                LayoutBuilder(builder: (context, constraints) {
                  final isCompact = constraints.maxWidth < 900;
                  final cardWidth = isCompact
                      ? constraints.maxWidth
                      : (constraints.maxWidth / 2) - 10;

                  return Wrap(
                    spacing: 20,
                    runSpacing: 12,
                    children: [
                      Obx(() {
                        final transaction = controller.transaction.value;
                        return _summaryCard(
                          width: cardWidth,
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
                        );
                      }),
                      Obx(() {
                        final transaction = controller.transaction.value;
                        return _summaryCard(
                          width: cardWidth,
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
                        );
                      }),
                    ],
                  );
                }),
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
                Obx(() => Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () async {
                                  await controller.runWithLoading(
                                      () => controller.printKitchen(true));
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            disabledBackgroundColor: const Color(0xffBDBDBD),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Print Kitchen',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                        ),
                        ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () async {
                                  await controller.runWithLoading(
                                      () => controller.printKitchen(false));
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            disabledBackgroundColor: const Color(0xffBDBDBD),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Print Bar',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                        ),
                        ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () async {
                                  await controller
                                      .runWithLoading(controller.printReceipt);
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            disabledBackgroundColor: const Color(0xffBDBDBD),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Print Copy',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Obx(() => controller.isLoading.value
              ? const Center(
                  child: Loading(
                    size: 42,
                    label: 'Sedang mencetak...',
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

Widget _summaryCard({required double width, required List<TableRow> children}) {
  return Container(
    width: width,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xff161616),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xff2C2C2C)),
    ),
    child: Table(
      columnWidths: const {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(0.2),
        2: FlexColumnWidth(4),
      },
      children: children,
    ),
  );
}
