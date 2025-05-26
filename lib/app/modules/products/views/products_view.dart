import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_getx/app/style/app_colors.dart';
import 'package:pos_getx/app/widgets/item_menu.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Products',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Aksi untuk mengelola kategori
                      Get.snackbar('Info', 'Manage Categories clicked',
                          snackPosition: SnackPosition.BOTTOM);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1A1A1A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.tune_outlined, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Manage Categories',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xff1A1A1A),
              ),
              child: Column(
                children: [
                  TabBar(
                    controller: controller.tabController,
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: controller.listTab.map((tab) {
                      return Tab(
                        text: tab.text,
                        icon: tab.icon,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color.fromARGB(255, 32, 32, 32),
                ),
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    GridView.count(
                      crossAxisCount: 5,
                      childAspectRatio: 0.73,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2,
                            ),
                            color: const Color(0xff1A1A1A),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add,
                                  color: AppColors.primary, size: 50),
                              const SizedBox(height: 10),
                              const Text(
                                'Add New Product',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        itemMenu(
                          image: 'assets/images/cappuccino.jpeg',
                          title: 'Cappucino',
                          price: 'Rp. 25.000',
                          item: '1 item',
                          edit: true,
                        ),
                        itemMenu(
                          image: 'assets/images/cappuccino.jpeg',
                          title: 'Cappucino',
                          price: 'Rp. 25.000',
                          item: '1 item',
                          edit: true,
                        ),
                        itemMenu(
                          image: 'assets/images/cappuccino.jpeg',
                          title: 'Latte',
                          price: 'Rp. 30.000',
                          item: '1 item',
                          edit: true,
                        ),
                        itemMenu(
                          image: 'assets/images/espresso.jpg',
                          title: 'Espresso',
                          price: 'Rp. 20.000',
                          item: '1 item',
                          edit: true,
                        ),
                        itemMenu(
                          image: 'assets/images/macchiato.jpeg',
                          title: 'Macchiato',
                          price: 'Rp. 35.000',
                          item: '1 item',
                          edit: true,
                        ),
                      ],
                    ),
                    Center(
                        child: Text('Food Products',
                            style: TextStyle(color: Colors.white))),
                    Center(
                        child: Text('Drink Products',
                            style: TextStyle(color: Colors.white))),
                    Center(
                        child: Text('Dessert Products',
                            style: TextStyle(color: Colors.white))),
                    Center(
                        child: Text('Snack Products',
                            style: TextStyle(color: Colors.white))),
                    Center(
                        child: Text('Other Products',
                            style: TextStyle(color: Colors.white))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
