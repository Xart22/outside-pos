import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pos_getx/app/data/repository/transaction_repository.dart';
import 'package:pos_getx/app/modules/casier/controllers/casier_controller.dart';
import 'package:pos_getx/app/modules/history/controllers/history_controller.dart';
import 'package:pos_getx/app/modules/products/controllers/products_controller.dart';
import 'package:pos_getx/app/modules/settings/controllers/settings_controller.dart';
import 'package:pos_getx/app/modules/variants/controllers/variants_controller.dart';
import 'package:pos_getx/app/service/global_state.dart';
import 'package:pos_getx/app/utils/rupiah_formater.dart';
import 'package:pos_getx/app/widgets/Input_field.dart';
import 'package:pos_getx/app/widgets/snackbar.dart';

class HomeController extends GetxController {
  final pageIndex = "Casier".obs;
  final globalState = Get.find<GlobalState>();
  final casierController = Get.find<CasierController>();
  final menuController = Get.find<MenuController>();
  final settingsController = Get.find<SettingsController>();
  final productsController = Get.find<ProductsController>();
  final variantsController = Get.find<VariantsController>();
  final historyController = Get.find<HistoryController>();
  final isCashDrawerOpen = false.obs;
  TextEditingController startingBalanceController = TextEditingController();
  void changePage(String index) async {
    if (index == "Casier") {
      await casierController.getAllData();
    } else if (index == "Menu") {
      await productsController.getAllData();
    } else if (index == "Settings") {
      await settingsController.getSettingsData();
    } else if (index == "Variants") {
      await variantsController.getVariants();
    } else if (index == "History") {
      historyController.fetchTransactions();
    }

    pageIndex.value = index;
  }

  void getCashDrawer() async {
    isCashDrawerOpen.value = await TransactionRepository.startOpenCashDrawer();
    print("Cash Drawer Open: ${isCashDrawerOpen.value}");
    if (isCashDrawerOpen.value) {
      casierController.orderNumber.value =
          await TransactionRepository.getOrderNumber();
    } else {
      showDialog();
    }
  }

  void showDialog() {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        backgroundColor: const Color(0xff121212),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        title: Text("Starting Balance"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InputField(
              label: "Starting Balance",
              hint: "Enter starting balance",
              controller: startingBalanceController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyInputFormatter(),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () async {
                    if (startingBalanceController.text.isEmpty) {
                      showSnackbar("Error", "Starting balance cannot be empty");
                      return;
                    }
                    globalState.isLoading.value = true;
                    final result =
                        await TransactionRepository.updatetOpenCashDrawer(
                      startingBalanceController.text.replaceAll('Rp', ''),
                    );
                    globalState.isLoading.value = false;
                    if (result) {
                      Get.back();
                      showSnackbar("Success", "Starting balance has been set");
                      casierController.orderNumber.value =
                          await TransactionRepository.getOrderNumber();
                    } else {
                      showSnackbar("Error", "Failed to set starting balance");
                    }
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    globalState.init();
    getCashDrawer();
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
