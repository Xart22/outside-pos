import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pos_getx/app/modules/casier/views/payment_view.dart';
import 'package:pos_getx/app/utils/rupiah_formater.dart';
import 'package:pos_getx/app/widgets/item_menu.dart';
import 'package:pos_getx/app/widgets/search.dart';

import '../controllers/casier_controller.dart';

class CasierView extends GetView<CasierController> {
  const CasierView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      resizeToAvoidBottomInset: false,
      body: Row(
        children: [
          Container(
            width: Get.width / 1.8,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 32, 32, 32),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Outside Coffee",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            )),
                        Obx(
                          () => Text(controller.today.value,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                      width: 300,
                      child: InputTextField(
                        controller: controller.searchController,
                        hintText: 'Search',
                        onChanged: (value) {
                          controller.searchMenu(value);
                        },
                      ),
                    ),
                  ],
                ),
                Container(
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
                          return Tab(
                            text: tab.text,
                            icon: tab.icon,
                          );
                        }).toList(),
                      )),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color.fromARGB(255, 32, 32, 32),
                    ),
                    child: Obx(() => TabBarView(
                          controller: controller.tabController,
                          children: controller.listTab.map((tab) {
                            if (tab.text == 'All') {
                              if (controller.filteredMenu.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No menu found',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              }
                              return GridView.count(
                                crossAxisCount: 4,
                                childAspectRatio: 0.75,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                children: [
                                  ...controller.filteredMenu.map((menu) {
                                    return itemMenu(
                                      image: menu.image,
                                      title: menu.name,
                                      price: formatRupiah(menu.price),
                                      item: '${menu.stock} items',
                                      edit: false,
                                      addToCart: () {
                                        controller.addToCart(menu);
                                      },
                                    );
                                  }),
                                ],
                              );
                            } else {
                              return GridView.count(
                                crossAxisCount: 4,
                                childAspectRatio: 0.75,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                children: controller.filteredMenu
                                    .where((menu) =>
                                        menu.category.name == tab.text)
                                    .map((menu) {
                                  return itemMenu(
                                    image: menu.image,
                                    title: menu.name,
                                    price: formatRupiah(menu.price),
                                    item: '${menu.stock} items',
                                    edit: false,
                                    addToCart: () {
                                      controller.addToCart(menu);
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
          Expanded(
            child: Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xff1A1A1A),
                ),
                child: PaymentView()),
          ),
        ],
      ),
    );
  }
}
