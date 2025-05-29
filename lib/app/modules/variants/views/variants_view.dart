import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/variants_controller.dart';

class VariantsView extends GetView<VariantsController> {
  const VariantsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Variants',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/variant-form');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1A1A1A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Add Variant',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xff1e1e1e),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(() {
                if (controller.variants.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Variants Available',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: controller.variants.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: const Color(0xff2c2c2c),
                      child: ListTile(
                          title: Text(
                            controller.variants[index].name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            controller.variants[index].options
                                .map((option) => option.name)
                                .join(', '),
                            style: const TextStyle(color: Colors.white70),
                          ),
                          style: ListTileStyle.drawer,
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white70,
                          ),
                          onTap: () {
                            Get.toNamed('/variant-form', arguments: {
                              'variant': controller.variants[index],
                              'isEdit': true,
                            });
                          }),
                    );
                  },
                );
              }),
            )),
          ],
        ),
      ),
    );
  }
}
