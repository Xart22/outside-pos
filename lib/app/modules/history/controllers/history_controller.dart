import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_getx/app/data/model/transaction_model.dart';
import 'package:pos_getx/app/data/repository/transaction_repository.dart';

class HistoryController extends GetxController {
  TextEditingController searchController = TextEditingController();
  final transactions = <Transaction>[].obs;
  final cashDrawerStart = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  void fetchTransactions() async {
    final data = await TransactionRepository.getTransactions();
    transactions.assignAll(data.transactions);
    print('Fetched ${data.cashDrawerStart} as cash drawer start');
    cashDrawerStart.value = data.cashDrawerStart;
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
