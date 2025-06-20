import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_getx/app/style/app_colors.dart';
import 'package:pos_getx/app/utils/rupiah_formater.dart';
import 'package:pos_getx/app/widgets/item_menu.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff121212),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
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
                    controller.showModalCategoryBottomSheet(context);
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
                        'Add Categories',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xff1A1A1A),
              ),
              child: Obx(() => TabBar(
                    controller: controller.tabController,
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: controller.listTab.map((tab) {
                      return GestureDetector(
                        child: Tab(
                          text: tab.text,
                          icon: tab.icon,
                        ),
                      );
                    }).toList(),
                  )),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color.fromARGB(255, 32, 32, 32),
                ),
                child: Obx(() => TabBarView(
                      controller: controller.tabController,
                      children: controller.listTab.map((tab) {
                        if (tab.text == 'All') {
                          return GridView.count(
                            crossAxisCount: 5,
                            childAspectRatio: 0.79,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed('/menu-form')?.then((value) {
                                    controller.getAllData();
                                  });
                                },
                                child: Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.add,
                                          color: AppColors.primary, size: 50),
                                      SizedBox(height: 10),
                                      Text(
                                        'Add New Product',
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ...controller.listMenu.map((menu) {
                                return itemMenu(
                                  image: menu.image,
                                  title: menu.name,
                                  price: formatRupiah(menu.price),
                                  item: '${menu.stock} items',
                                  edit: true,
                                  onTap: () {
                                    Get.toNamed(
                                      '/menu-form',
                                      arguments: {'menu': menu},
                                      preventDuplicates: false,
                                    )?.then((value) {
                                      controller.getAllData();
                                    });
                                  },
                                );
                              }),
                            ],
                          );
                        } else {
                          return GridView.count(
                            crossAxisCount: 5,
                            childAspectRatio: 0.79,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            children: controller.listMenu
                                .where((menu) => menu.category.name == tab.text)
                                .map((menu) {
                              return itemMenu(
                                image: menu.image,
                                title: menu.name,
                                price: formatRupiah(menu.price),
                                item: '${menu.stock} items',
                                edit: true,
                                onTap: () {
                                  Get.toNamed(
                                    '/menu-form',
                                    arguments: {'menu': menu},
                                    preventDuplicates: false,
                                  )?.then((value) {
                                    controller.getAllData();
                                  });
                                },
                              );
                            }).toList(),
                          );
                        }
                      }).toList(),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
