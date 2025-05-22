import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
                      _item(
                        image: 'assets/images/food1.jpg',
                        title: 'Cappucino',
                        price: 'Rp. 25.000',
                        item: '1 item',
                      ),
                      _item(
                        image: 'assets/images/food2.jpg',
                        title: 'Latte',
                        price: 'Rp. 30.000',
                        item: '1 item',
                      ),
                      _item(
                        image: 'assets/images/food3.jpg',
                        title: 'Espresso',
                        price: 'Rp. 20.000',
                        item: '1 item',
                      ),
                      _item(
                        image: 'assets/images/food4.jpg',
                        title: 'Macchiato',
                        price: 'Rp. 35.000',
                        item: '1 item',
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

  Widget _item({
    required String image,
    required String title,
    required String price,
    required String item,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0xff1A1A1A),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 18,
                ),
              ),
              Text(
                item,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
