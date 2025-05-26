import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pos_getx/app/widgets/item_menu.dart';
import 'package:pos_getx/app/widgets/search.dart';

import '../controllers/casier_controller.dart';

class CasierView extends GetView<CasierController> {
  const CasierView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: Row(
        children: [
          Container(
            width: Get.width / 1.5,
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
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 4,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      itemMenu(
                        image: 'assets/images/cappuccino.jpeg',
                        title: 'Cappucino',
                        price: 'Rp. 25.000',
                        item: '1 item',
                        edit: false,
                      ),
                      itemMenu(
                        image: 'assets/images/cappuccino.jpeg',
                        title: 'Latte',
                        price: 'Rp. 30.000',
                        item: '1 item',
                        edit: false,
                      ),
                      itemMenu(
                        image: 'assets/images/espresso.jpg',
                        title: 'Espresso',
                        price: 'Rp. 20.000',
                        item: '1 item',
                        edit: false,
                      ),
                      itemMenu(
                        image: 'assets/images/macchiato.jpeg',
                        title: 'Macchiato',
                        price: 'Rp. 35.000',
                        item: '1 item',
                        edit: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xff1A1A1A),
              ),
              child: Center(
                child: Text(
                  'Payment',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
