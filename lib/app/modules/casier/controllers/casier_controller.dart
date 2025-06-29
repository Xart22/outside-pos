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
import 'package:pos_getx/app/data/repository/transaction_repository.dart';
import 'package:pos_getx/app/service/global_state.dart';
import 'package:pos_getx/app/style/app_colors.dart';
import 'package:pos_getx/app/utils/generate_wifi.dart';
import 'package:pos_getx/app/utils/rupiah_formater.dart';
import 'package:pos_getx/app/widgets/Input_field.dart';
import 'package:pos_getx/app/widgets/snackbar.dart';
import 'package:collection/collection.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:image/image.dart' as img;
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class CasierController extends GetxController with GetTickerProviderStateMixin {
  final globalState = Get.find<GlobalState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController tableNumberController = TextEditingController();
  TextEditingController cashAmountController = TextEditingController();
  TextEditingController referenceCodeController = TextEditingController();
  TextEditingController issueController = TextEditingController();
  TextEditingController discountController = TextEditingController();

  final orderNumber = ''.obs;
  final paymentMethod = ''.obs;
  final cashAmountError = ''.obs;
  final changeAmount = 0.obs;
  final subTotal = 0.obs;
  final discount = 0.0.obs;
  final totalDiscount = 0.obs;
  final totalPrice = 0.obs;
  final today = "".obs;
  final listMenu = <Menu>[].obs;
  final filteredMenu = <Menu>[].obs;
  final listCategories = <Category>[].obs;
  final isDineIn = true.obs;
  final dateOrder = ''.obs;

  final listCart = <CartItem>[].obs;

  final randomUserWifi = ''.obs;
  final macPrinterCasier = '66:32:F9:51:03:BF';

  final userWifi = ''.obs;
  final passwordWifi = ''.obs;

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

  getOrderNumber() async {
    orderNumber.value = await TransactionRepository.getOrderNumber();
  }

  getAllData() async {
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
    subTotal.value = total;
    totalDiscount.value = (total * discount.value).toInt();
    totalPrice.value = total - totalDiscount.value;
  }

  void clearCart() async {
    listCart.clear();
    totalPrice.value = 0;
    searchController.clear();
    filteredMenu.value = listMenu;
    customerNameController.clear();
    cashAmountController.clear();
    paymentMethod.value = '';
    cashAmountError.value = '';
    changeAmount.value = 0;
    subTotal.value = 0;
    isDineIn.value = true;
    issueController.clear();
    totalDiscount.value = 0;
    discount.value = 0.0;
    discountController.clear();
    dateOrder.value = '';
    randomUserWifi.value = '';
    userWifi.value = '';
    passwordWifi.value = '';
    referenceCodeController.clear();
    tableNumberController.clear();
    await getOrderNumber();
  }

  void paymentModal() {
    if (listCart.isEmpty) {
      showSnackbar(
          'Cart is empty', 'Please add items to the cart before proceeding.');
      return;
    }
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        backgroundColor: const Color(0xff121212),
        content: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xff121212),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
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
                Obx(() => Text(
                      'Total Discount: ${formatRupiah(totalDiscount.value)}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    )),
                SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          discount.value = 0.1; // 10% discount
                          discountController.text = '10';
                          calculateTotalPrice();
                        },
                        child: Text('10%')),
                    SizedBox(width: 8),
                    ElevatedButton(
                        onPressed: () {
                          discount.value = 0.2; // 20% discount
                          discountController.text = '20';
                          calculateTotalPrice();
                        },
                        child: Text('20%')),
                    SizedBox(width: 8),
                    ElevatedButton(
                        onPressed: () {
                          discount.value = 0.3; // 30% discount
                          discountController.text = '30';
                          calculateTotalPrice();
                        },
                        child: Text('30%')),
                    SizedBox(width: 8),
                    ElevatedButton(
                        onPressed: () {
                          discount.value = 0.4; // 40% discount
                          discountController.text = '40';
                          calculateTotalPrice();
                        },
                        child: Text('40%')),
                  ],
                ),
                InputField(
                  label: "Discount",
                  hint: "Enter discount percentage",
                  controller: discountController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                SizedBox(height: 8),
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
                        payWithQris();
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
                SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      discount.value = 0.0;
                      discountController.clear();
                      calculateTotalPrice();
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      disabledBackgroundColor: const Color(0xffBDBDBD),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void payWithQris() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    userWifi.value = timestamp.substring(timestamp.length - 6);
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        backgroundColor: const Color(0xff121212),
        content: SingleChildScrollView(
          child: Column(
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
                    label: "APPR CODE",
                    hint: "Enter APPR CODE",
                    controller: referenceCodeController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    errorText: cashAmountError.value.isNotEmpty
                        ? cashAmountError.value
                        : null,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  )),
              SizedBox(height: 5),
              InputField(
                label: "VENDOR",
                hint: "Enter vendor",
                controller: issueController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                errorText: cashAmountError.value.isNotEmpty
                    ? cashAmountError.value
                    : null,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        disabledBackgroundColor: const Color(0xffBDBDBD),
                      ),
                      onPressed: () {
                        referenceCodeController.clear();
                        issueController.clear();
                        Get.back();
                      },
                      child: const Text('Cancel',
                          style: TextStyle(fontSize: 12, color: Colors.white))),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        disabledBackgroundColor: const Color(0xffBDBDBD),
                      ),
                      onPressed: () async {
                        if (referenceCodeController.text.isEmpty) {
                          showSnackbar('Error', 'APPR CODE cannot be empty');
                          return;
                        }
                        globalState.isLoading.value = true;

                        final result =
                            await TransactionRepository.processTransaction(
                          transactionId: orderNumber.value,
                          type: isDineIn.value ? 'DINE_IN' : 'TAKE_AWAY',
                          customerName: customerNameController.text,
                          paymentMethod: paymentMethod.value,
                          subtotal: subTotal.value.toString(),
                          total: totalPrice.value.toString(),
                          discount: totalDiscount.value.toString(),
                          paymentProof:
                              "${referenceCodeController.text} - ${issueController.text}",
                          tableNumber: tableNumberController.text,
                          items: listCart.map((item) {
                            return {
                              'menu_id': item.menuId,
                              'quantity': item.qty.value,
                              'options': item.options.entries.map((e) {
                                return {
                                  'variant_id': e.key,
                                  'variant_option_id': e.value,
                                };
                              }).toList(),
                            };
                          }).toList(),
                        );

                        if (result) {
                          await createHotspotUser(userWifi.value,
                              customerNameController.text.replaceAll(' ', '_'),
                              profile: 'customer-regular');
                          await printReceipt(userWifi.value, dateOrder.value);
                          await getAllData();
                          globalState.isLoading.value = false;
                          showSnackbar('Success', 'Payment successful');
                          dialogPrint();
                        } else {
                          globalState.isLoading.value = false;
                          showSnackbar('Error', 'Payment failed');
                        }
                      },
                      child: const Text('Settle',
                          style: TextStyle(fontSize: 12, color: Colors.white))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void payWithCash() {
    dateOrder.value =
        DateFormat('dd-MM-yyyy HH:mm:ss', 'id_ID').format(DateTime.now());
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    userWifi.value = timestamp.substring(timestamp.length - 6);
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xff121212),
        content: SingleChildScrollView(
          child: Column(
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
                    textInputAction: TextInputAction.done,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
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
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        disabledBackgroundColor: const Color(0xffBDBDBD),
                      ),
                      onPressed: () async {
                        if (cashAmountError.value.isNotEmpty) {
                          showSnackbar('Error', cashAmountError.value);
                          return;
                        }

                        final cashAmount = int.tryParse(cashAmountController
                                .text
                                .replaceAll('Rp. ', '')
                                .replaceAll('.', '')) ??
                            0;

                        if (cashAmount < totalPrice.value) {
                          showSnackbar('Error', 'Insufficient cash amount');
                          return;
                        }
                        globalState.isLoading.value = true;

                        final result =
                            await TransactionRepository.processTransaction(
                          transactionId: orderNumber.value,
                          type: isDineIn.value ? 'DINE_IN' : 'TAKE_AWAY',
                          customerName: customerNameController.text,
                          subtotal: subTotal.value.toString(),
                          paymentMethod: paymentMethod.value,
                          cash:
                              cashAmountController.text.replaceAll('Rp. ', ''),
                          total: totalPrice.value.toString(),
                          change: changeAmount.value.toString(),
                          discount: totalDiscount.value.toString(),
                          paymentProof:
                              "${referenceCodeController.text} - ${issueController.text}",
                          tableNumber: tableNumberController.text,
                          items: listCart.map((item) {
                            return {
                              'menu_id': item.menuId,
                              'quantity': item.qty.value,
                              'options': item.options.entries.map((e) {
                                return {
                                  'variant_id': e.key,
                                  'variant_option_id': e.value,
                                };
                              }).toList(),
                            };
                          }).toList(),
                        );
                        if (result) {
                          await createHotspotUser(userWifi.value,
                              customerNameController.text.replaceAll(' ', '_'),
                              profile: 'customer-regular');
                          await printReceipt(userWifi.value, dateOrder.value);
                          await getAllData();
                          globalState.isLoading.value = false;
                          showSnackbar('Success', 'Payment successful');
                          dialogPrint();
                        } else {
                          globalState.isLoading.value = false;
                          showSnackbar('Error', 'Payment failed');
                        }
                      },
                      child: const Text('Pay',
                          style: TextStyle(fontSize: 12, color: Colors.white))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void dialogPrint() {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        backgroundColor: const Color(0xff121212),
        content:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          ElevatedButton(
            onPressed: () async {
              globalState.isLoading.value = true;
              await printKitchen(true);
              globalState.isLoading.value = false;
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              disabledBackgroundColor: const Color(0xffBDBDBD),
            ),
            child: const Text('Print for Kitchen',
                style: TextStyle(fontSize: 12, color: Colors.white)),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () async {
              globalState.isLoading.value = true;
              await printKitchen(false);
              globalState.isLoading.value = false;
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              disabledBackgroundColor: const Color(0xffBDBDBD),
            ),
            child: const Text('Print for bar',
                style: TextStyle(fontSize: 12, color: Colors.white)),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () async {
              globalState.isLoading.value = true;
              await printReceipt(
                userWifi.value,
                dateOrder.value,
              );
              globalState.isLoading.value = false;
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              disabledBackgroundColor: const Color(0xffBDBDBD),
            ),
            child: const Text('Print Copy',
                style: TextStyle(fontSize: 12, color: Colors.white)),
          ),
        ]),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                clearCart();
                Get.back();
                Get.back();
                Get.back();
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                disabledBackgroundColor: const Color(0xffBDBDBD),
              ),
              child: const Text('Done',
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          ),
        ],
      ),
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

  Future<void> printKitchen(bool kitchen) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    var kitchenBytes = <int>[];

    // Header
    kitchenBytes += generator.reset();
    kitchenBytes += generator.text('================================');
    kitchenBytes += generator.text(
      kitchen ? 'Kitchen Order' : 'Bar Order',
      styles: PosStyles(align: PosAlign.center, fontType: PosFontType.fontB),
    );
    kitchenBytes +=
        generator.text('==========================================');

    // Order Info
    kitchenBytes += generator.text(
      'Order from: ${customerNameController.text}',
      styles: PosStyles(align: PosAlign.center),
    );
    kitchenBytes += generator.text(
      'Table: ${tableNumberController.text}',
      styles: PosStyles(align: PosAlign.center),
    );
    kitchenBytes += generator.text(
      'Order Number: ${orderNumber.value}',
      styles: PosStyles(align: PosAlign.center),
    );
    kitchenBytes += generator.text(
      'Order Date: ${DateFormat('dd/MM/yyyy HH:mm:ss', 'id_ID').format(DateTime.now())}',
      styles: PosStyles(align: PosAlign.center),
    );
    kitchenBytes +=
        generator.text('==========================================');

    // Menu Items
    for (var item in listCart) {
      final menu = listMenu.firstWhere((m) => m.id == item.menuId);

      // Baris utama (qty + nama menu)
      kitchenBytes += generator.row([
        PosColumn(
          text: 'x${item.qty.value}',
          width: 1,
          styles: PosStyles(align: PosAlign.left, fontType: PosFontType.fontB),
        ),
        PosColumn(
          text: menu.name,
          width: 11,
          styles: PosStyles(align: PosAlign.left, fontType: PosFontType.fontB),
        ),
      ]);

      // Baris tambahan untuk tiap opsi
      for (var entry in item.options.entries) {
        final variant =
            menu.variantsElement.firstWhere((v) => v.variant.id == entry.key);
        final option =
            variant.variant.options.firstWhere((o) => o.id == entry.value);

        kitchenBytes += generator.row([
          PosColumn(text: '', width: 1), // kosong untuk indentasi
          PosColumn(
            text: '- ${variant.variant.name}: ${option.name}',
            width: 11,
            styles: PosStyles(align: PosAlign.left),
          ),
        ]);
      }

      // Spasi antar item
      kitchenBytes += generator.feed(1);
    }

    // Footer
    kitchenBytes +=
        generator.text('==========================================');
    kitchenBytes += generator.feed(3);

    // Kirim ke printer
    await _safePrint(macPrinterCasier, kitchenBytes);
  }

  Future<void> printReceipt(String userWifi, String dateOrder,
      {bool isCopy = false}) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    var bytes = <int>[];
    bytes += generator.reset();
    try {
      // === Generate Logo Image ===
      if (!isCopy) {
        final data = await rootBundle.load('assets/logo/oc.png');
        final image = img.decodeImage(data.buffer.asUint8List());

        if (image == null) throw Exception("Logo image could not be decoded.");

        final resized = img.copyResize(image, width: 200, height: 150);
        final safeImage = img.Image.from(resized);
        bytes += generator.imageRaster(safeImage, align: PosAlign.center);
        bytes += generator.feed(1);
        bytes += generator.text(
          'Jl. Pandanwangi, Cinunuk, Kec. Cileunyi',
          styles:
              PosStyles(align: PosAlign.center, fontType: PosFontType.fontB),
        );
        bytes += generator.text(
          '0822-9555-3530',
          styles:
              PosStyles(align: PosAlign.center, fontType: PosFontType.fontB),
        );
      }
      // === Generate Receipt Bytes ===
      bytes += generator.text('==========================================');

      // === Informasi Umum ===
      bytes += _buildRow('Date', dateOrder, generator);
      bytes += _buildRow('Order Number', orderNumber.value, generator);
      bytes += _buildRow('Customer', customerNameController.text, generator);
      bytes += _buildRow('Table Number', tableNumberController.text, generator);
      bytes += _buildRow('Cashier', 'Admin', generator);
      bytes += generator.text('==========================================');

      // === List Cart ===
      for (var item in listCart) {
        final menu = listMenu.firstWhere((m) => m.id == item.menuId);
        bytes += generator.row([
          PosColumn(text: 'x${item.qty.value}', width: 1),
          PosColumn(text: menu.name, width: 6),
          PosColumn(
            text: formatRupiah(calculatePriceItem(item) * item.qty.value),
            width: 5,
            styles: PosStyles(align: PosAlign.right),
          ),
        ]);
      }

      bytes += generator.text('==========================================');

      // === Payment Summary ===
      bytes += _buildRow(
          'Payment Method', paymentMethod.value.toUpperCase(), generator);
      bytes += _buildRow('Subtotal', formatRupiah(subTotal.value), generator);
      bytes += _buildRow(
        'Discount',
        "${formatRupiah(totalDiscount.value)} (${(discount.value * 100).toStringAsFixed(0)}%)",
        generator,
      );
      bytes += _buildRow(
        'Total',
        formatRupiah(subTotal.value - totalDiscount.value),
        generator,
      );

      if (paymentMethod.value == 'cash') {
        bytes += _buildRow('Cash', cashAmountController.text, generator);
        bytes +=
            _buildRow('Change', formatRupiah(changeAmount.value), generator);
      } else {
        bytes += _buildRow(
          'Reference Code',
          "${referenceCodeController.text} - ${issueController.text}",
          generator,
        );
      }

      // === Wifi Section ===
      bytes += generator.text('==========================================');
      bytes += generator.text('Wifi Outside',
          styles: PosStyles(align: PosAlign.center));
      bytes += _buildRow('Username', userWifi, generator);
      bytes += _buildRow('Password',
          customerNameController.text.replaceAll(' ', '_'), generator);
      bytes += generator.text('==========================================');

      // === Closing ===
      bytes += generator.text('Thank you for your visit',
          styles: PosStyles(align: PosAlign.center));
      bytes += generator.text('See you again',
          styles: PosStyles(align: PosAlign.center));
      bytes += generator.feed(3);

      // === Print to Casier ===
      await _safePrint(macPrinterCasier, bytes);
    } catch (e) {
      print('🛑 Print failed: $e');
    }
  }

  Future<void> _safePrint(String macAddress, List<int> bytes) async {
    try {
      await PrintBluetoothThermal.connect(macPrinterAddress: macAddress);
      bool isConnected = await PrintBluetoothThermal.connectionStatus;
      if (isConnected) {
        await PrintBluetoothThermal.writeBytes(bytes);
      } else {
        print("⚠️ Failed to connect to printer: $macAddress");
      }
    } catch (e) {
      print("🛑 Error printing to $macAddress: $e");
    } finally {
      // await PrintBluetoothThermal.disconnect;
    }
  }

  List<int> _buildRow(String label, String value, Generator generator) {
    return generator.row([
      PosColumn(text: label, width: 5),
      PosColumn(text: ':', width: 1),
      PosColumn(text: value, width: 6),
    ]);
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
