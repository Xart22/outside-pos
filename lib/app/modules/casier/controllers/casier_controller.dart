import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pos_getx/app/data/model/cart_model.dart';
import 'package:pos_getx/app/data/model/categories_model.dart';
import 'package:pos_getx/app/data/model/menu_model.dart';
import 'package:pos_getx/app/data/repository/categories_repository.dart';
import 'package:pos_getx/app/data/repository/products_repository.dart';
import 'package:pos_getx/app/style/app_colors.dart';
import 'package:pos_getx/app/utils/rupiah_formater.dart';
import 'package:pos_getx/app/widgets/Input_field.dart';
import 'package:pos_getx/app/widgets/snackbar.dart';
import 'package:collection/collection.dart';

class CasierController extends GetxController with GetTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerTableController = TextEditingController();
  TextEditingController cashAmountController = TextEditingController();

  final paymentMethod = ''.obs;
  final cashAmountError = ''.obs;
  final changeAmount = 0.obs;

  final today = "".obs;
  final listMenu = <Menu>[].obs;
  final filteredMenu = <Menu>[].obs;
  final listCategories = <Category>[].obs;
  final isDineIn = true.obs;

  final listCart = <CartItem>[].obs;
  final totalPrice = 0.obs;

  late TabController tabController;
  final listTab = [
    Tab(
      text: 'All',
      icon: Icon(IconData(
        0xe07e,
        fontFamily: 'MaterialIcons',
      )),
    ),
  ].obs;

  void getAllData() async {
    listMenu.value = await ProductsRepository.getProducts();
    filteredMenu.value = listMenu;

    listCategories.value = await CategoriesRepository.getCategories();
    for (var category in listCategories) {
      final exists = listTab.any((tab) => tab.text == category.name);
      if (!exists) {
        listTab.add(
          Tab(
            text: category.name,
            icon: Icon(IconData(
              int.tryParse(category.icon ?? '0xe07e') ?? 0xe07e,
              fontFamily: 'MaterialIcons',
            )),
          ),
        );
      }
    }

    tabController = TabController(length: listTab.length, vsync: this);
  }

  void searchMenu(String query) {
    if (query.isEmpty) {
      filteredMenu.value = listMenu;
    } else {
      filteredMenu.value = listMenu
          .where(
              (menu) => menu.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void addToCart(Menu menu) {
    final eq = const MapEquality();

    if (menu.variantsElement.isEmpty) {
      final existingItem = listCart.firstWhereOrNull(
        (item) => item.menuId == menu.id && item.options.isEmpty,
      );

      if (existingItem != null) {
        existingItem.qty.value++;
      } else {
        listCart.add(CartItem(
          menuId: menu.id,
          qty: 1.obs,
          options: {},
          note: '',
        ));
      }

      calculateTotalPrice();
      return;
    }

    // Menu dengan variant: buka form
    Get.toNamed('/casier-form', arguments: {'menu': menu})?.then((value) {
      if (value is! CartItem) {
        showSnackbar('Error', 'Failed to add item to cart.');
        return;
      }

      final existingItem = listCart.firstWhereOrNull((item) =>
          item.menuId == value.menuId &&
          eq.equals(item.options, value.options));

      if (existingItem != null) {
        existingItem.qty.value++;
      } else {
        listCart.add(value);
      }

      calculateTotalPrice();
    });
  }

  int calculatePriceItem(CartItem item) {
    final menu = listMenu.firstWhere((m) => m.id == item.menuId);
    final variantsSelected = item.options.entries
        .map((e) => menu.variantsElement
            .firstWhere((v) => v.variant.id == e.key)
            .variant
            .options
            .firstWhere((o) => o.id == e.value))
        .toList();

    int basePrice = menu.price.toInt();
    for (var variant in variantsSelected) {
      basePrice += variant.price;
    }
    return basePrice;
  }

  void removeFromCart(int index) {
    if (index >= 0 && index < listCart.length) {
      listCart.removeAt(index);
    } else {}
  }

  void calculateTotalPrice() {
    int total = 0;
    for (var item in listCart) {
      total += calculatePriceItem(item) * item.qty.value;
    }
    totalPrice.value = total;
  }

  void clearCart() {
    listCart.clear();
    totalPrice.value = 0;
    searchController.clear();
    filteredMenu.value = listMenu;
    customerNameController.clear();
    customerTableController.clear();
    cashAmountController.clear();
    paymentMethod.value = '';
    cashAmountError.value = '';
    changeAmount.value = 0;
    isDineIn.value = true;
  }

  void paymentModal() {
    if (listCart.isEmpty) {
      showSnackbar(
          'Cart is empty', 'Please add items to the cart before proceeding.');
      return;
    }
    Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xff121212),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Payment',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Obx(() => Text(
                  'Total Price: ${formatRupiah(totalPrice.value)}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                )),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    paymentMethod.value = 'cash';
                    payWithCash();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: const Color(0xffBDBDBD),
                  ),
                  child: const Text(
                    'Cash',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    paymentMethod.value = 'qris';
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonLight,
                    disabledBackgroundColor: const Color(0xffBDBDBD),
                  ),
                  child: const Text(
                    'QRIS',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void payWithCash() {
    Get.defaultDialog(
      backgroundColor: const Color(0xff121212),
      titleStyle: TextStyle(color: Colors.white, fontSize: 20),
      contentPadding: EdgeInsets.all(16),
      radius: 10,
      title: 'Payment',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => Text(
                'Total Price: ${formatRupiah(totalPrice.value)}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              )),
          SizedBox(height: 16),
          Obx(() => InputField(
                label: "Cash Amount",
                hint: "Enter cash amount",
                controller: cashAmountController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                errorText: cashAmountError.value.isNotEmpty
                    ? cashAmountError.value
                    : null,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter(),
                ],
                onTap: () {
                  cashAmountError.value = '';
                },
                onChanged: (value) {
                  cashAmountError.value = '';
                  calculateChange();
                },
              )),
          SizedBox(height: 5),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  cashAmountController.text = 'Rp. 10.000';
                  calculateChange();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff1A1A1A),
                  disabledBackgroundColor: const Color(0xffBDBDBD),
                ),
                child: const Text('10.000',
                    style: TextStyle(fontSize: 12, color: Colors.white)),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  cashAmountController.text = 'Rp. 20.000';
                  calculateChange();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff1A1A1A),
                  disabledBackgroundColor: const Color(0xffBDBDBD),
                ),
                child: const Text('20.000',
                    style: TextStyle(fontSize: 12, color: Colors.white)),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  cashAmountController.text = 'Rp. 50.000';
                  calculateChange();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff1A1A1A),
                  disabledBackgroundColor: const Color(0xffBDBDBD),
                ),
                child: const Text('50.000',
                    style: TextStyle(fontSize: 12, color: Colors.white)),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  cashAmountController.text = 'Rp. 100.000';
                  calculateChange();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff1A1A1A),
                  disabledBackgroundColor: const Color(0xffBDBDBD),
                ),
                child: const Text('100.000',
                    style: TextStyle(fontSize: 12, color: Colors.white)),
              ),
            ],
          ),
          SizedBox(height: 16),
          Obx(() {
            return Text(
              'Change: ${formatRupiah(changeAmount.value)}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            );
          }),
        ],
      ),
      confirm: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            disabledBackgroundColor: const Color(0xffBDBDBD),
          ),
          onPressed: () {
            if (cashAmountError.value.isNotEmpty) {
              showSnackbar('Error', cashAmountError.value);
              return;
            }

            final cashAmount = int.tryParse(cashAmountController.text
                    .replaceAll('Rp. ', '')
                    .replaceAll('.', '')) ??
                0;

            if (cashAmount < totalPrice.value) {
              showSnackbar('Error', 'Insufficient cash amount');
              return;
            }

            // Process payment here
            // For example, save the transaction to the database
            Get.back();
            Get.back();
            clearCart();

            showSnackbar('Success', 'Payment successful');
          },
          child: const Text('Pay',
              style: TextStyle(fontSize: 12, color: Colors.white))),
      cancel: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            disabledBackgroundColor: const Color(0xffBDBDBD),
          ),
          onPressed: () {
            cashAmountController.clear();
            cashAmountError.value = '';
            Get.back();
          },
          child: const Text('Cancel',
              style: TextStyle(fontSize: 12, color: Colors.white))),
    );
  }

  calculateChange() {
    final cashAmount = int.tryParse(cashAmountController.text
            .replaceAll('Rp. ', '')
            .replaceAll('.', '')) ??
        0;
    changeAmount.value = cashAmount - totalPrice.value;

    if (changeAmount.value < 0) {
      cashAmountError.value = 'Insufficient cash amount';
    } else {
      cashAmountError.value = '';
    }
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: listTab.length, vsync: this);
    getAllData();
    initializeDateFormatting();
    DateTime now = DateTime.now();
    today.value = DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(now);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
