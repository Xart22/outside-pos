import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pos_getx/app/modules/settings/views/printer/screen.dart';
import 'package:pos_getx/app/modules/settings/views/store/screen.dart';
import 'package:pos_getx/app/modules/settings/views/user/screen.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: Get.width / 4,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Color(0xff1A1A1A),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: _sideMenu(),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color(0xff1A1A1A),
                    ),
                    child: _pageView(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _sideMenu() {
    return Column(children: [
      const SizedBox(height: 20),
      Expanded(
        child: ListView(
          children: [
            _itemMenu(
              menu: 'Manage Store',
              icon: Icons.storefront_rounded,
              description: 'Manage your store',
            ),
            _itemMenu(
              menu: 'Manage User',
              icon: Icons.person_outline_rounded,
              description: 'Manage your account',
            ),
            _itemMenu(
              menu: 'Manage Printer',
              icon: Icons.print,
              description: 'Manage your printer',
            ),
          ],
        ),
      ),
    ]);
  }

  _pageView() {
    return Obx(() {
      switch (controller.pageIndex.value) {
        case 'Manage Store':
          return StoreView();
        case 'Manage User':
          return ManageUserView();
        case 'Manage Printer':
          return ManagePrinterView();
      }
      return const Center(
        child: Text(
          'Select a menu',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      );
    });
  }

  Widget _itemMenu(
      {required String menu,
      required IconData icon,
      required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: GestureDetector(
        onTap: () => controller.changePage(menu),
        child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Obx(() => AnimatedContainer(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: controller.pageIndex.value == menu
                        ? Colors.deepOrangeAccent
                        : Colors.transparent,
                  ),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.slowMiddle,
                  child: ListTile(
                    leading: Icon(
                      icon,
                      color: controller.pageIndex.value == menu
                          ? Colors.white
                          : Colors.grey,
                    ),
                    title: Text(
                      menu,
                      style: TextStyle(
                        color: controller.pageIndex.value == menu
                            ? Colors.white
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      description,
                      style: TextStyle(
                        color: controller.pageIndex.value == menu
                            ? Colors.white
                            : Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ))),
      ),
    );
  }
}
