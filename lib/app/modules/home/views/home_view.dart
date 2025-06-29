import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pos_getx/app/modules/casier/views/casier_view.dart';
import 'package:pos_getx/app/modules/history/views/history_view.dart';
import 'package:pos_getx/app/modules/products/views/products_view.dart';
import 'package:pos_getx/app/modules/settings/views/settings_view.dart';
import 'package:pos_getx/app/modules/variants/views/variants_view.dart';
import 'package:pos_getx/app/widgets/loading.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff121212),
      body: Stack(
        children: [
          Row(
            children: [
              Container(
                width: Get.width * 0.07,
                padding: const EdgeInsets.only(top: 24, right: 12, left: 12),
                margin: const EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                ),
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Color(0xff1A1A1A),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: _sideMenu(),
              ),
              Expanded(
                child: Container(
                  color: Color(0xff1A1A1A),
                  child: _pageView(),
                ),
              ),
            ],
          ),
          Obx(
            () => controller.globalState.isLoading.value
                ? Container(
                    color: Colors.white.withValues(alpha: 0.5),
                    child: const Center(
                      child: Loading(size: 50),
                    ),
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }

  _pageView() {
    return Obx(() {
      switch (controller.pageIndex.value) {
        case 'Casier':
          return CasierView();
        case 'Menu':
          return ProductsView();
        case 'Variants':
          return VariantsView();
        case 'History':
          return HistoryView();
        case 'Promos':
          return const Center(
            child: Text(
              'Promos',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          );
        case 'Settings':
          return SettingsView();
        default:
          return const Center(
            child: Text(
              'Home',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          );
      }
    });
  }

  Widget _sideMenu() {
    return Column(children: [
      _logo(),
      const SizedBox(height: 20),
      Expanded(
        child: ListView(
          children: [
            _itemMenu(
              menu: 'Casier',
              icon: Icons.post_add_rounded,
            ),
            _itemMenu(
              menu: 'Menu',
              icon: Icons.food_bank_rounded,
            ),
            _itemMenu(
              menu: 'Variants',
              icon: Icons.category_rounded,
            ),
            _itemMenu(
              menu: 'History',
              icon: Icons.history_toggle_off_rounded,
            ),
            _itemMenu(
              menu: 'Promos',
              icon: Icons.discount_outlined,
            ),
            _itemMenu(
              menu: 'Settings',
              icon: Icons.sports_soccer_outlined,
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _logo() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.deepOrangeAccent,
          ),
          child: const Icon(
            Icons.fastfood,
            color: Colors.white,
            size: 14,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'POSFood',
          style: TextStyle(
            color: Colors.white,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _itemMenu({required String menu, required IconData icon}) {
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
                  child: Column(
                    children: [
                      Icon(
                        icon,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        menu,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                ))),
      ),
    );
  }
}
