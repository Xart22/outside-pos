import 'dart:convert';
import 'package:pos_getx/app/data/model/show_transaction_model.dart';
import 'package:pos_getx/app/data/model/transaction_model.dart';
import 'package:pos_getx/app/data/provider/api_provider.dart';

class TransactionRepository {
  static Future<String> getOrderNumber() async {
    final response = await ApiClient.get('/transactions/order-number');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['order_number'].toString();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<bool> startOpenCashDrawer() async {
    final response = await ApiClient.get('/start-open-cash-drawer');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['cash_drawer'] == 0) {
        return false;
      }
      return true;
    } else {
      print('Failed to open cash drawer: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to open cash drawer');
    }
  }

  static Future<bool> updatetOpenCashDrawer(
    String startingBalance,
  ) async {
    final body = {'opening_balance': startingBalance.replaceAll('.', '')};
    final response = await ApiClient.post('/start-open-cash-drawer', body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['cash_drawer'] == null) {
        return false;
      }
      return true;
    } else {
      print('Failed to update cash drawer: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to update cash drawer');
    }
  }

  static Future<bool> processTransaction({
    required String transactionId,
    required String type,
    required String customerName,
    required String paymentMethod,
    required String tableNumber,
    String? subtotal,
    String? discount,
    String? cash,
    String? total,
    String? change,
    String? paymentProof,
    String? paymentStatus,
    List<dynamic> items = const [],
  }) async {
    final body = {
      'transaction_id': transactionId,
      'payment_method': paymentMethod,
      'type': type,
      'customer_name': customerName,
      'cash': cash?.replaceAll('.', ''),
      'total': total,
      'change': change,
      'discount': discount?.replaceAll('.', '') ?? '0',
      'sub_total': subtotal?.replaceAll('.', '') ?? '0',
      'payment_proof': paymentProof,
      'table_number': tableNumber,
      'items': items.map((item) {
        return {
          'menu_id': item['menu_id'],
          'quantity': item['quantity'],
          'options': item['options']?.map((option) {
                return {
                  'variant_id': option['variant_id'],
                  'variant_option_id': option['variant_option_id'],
                };
              }).toList() ??
              [],
        };
      }).toList(),
    };

    final response = await ApiClient.post('/transactions/process', body);

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to process transaction: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to process transaction');
    }
  }

  static Future<TransactionList> getTransactions() async {
    try {
      final response =
          await ApiClient.get('/transactions/get-trasactions-today');
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        final int cashDrawerStart =
            json.decode(response.body)['cash_drawer'] ?? 0;
        return TransactionList.fromJsonWithCashDrawer(data, cashDrawerStart);
      } else {
        throw Exception('Failed to load transactions');
      }
    } catch (e, s) {
      print('Error fetching transactions: $e');
      print('Stack trace: $s');
      throw Exception('Error fetching transactions');
    }
  }

  static Future<ShowTransaction> getTransactionById(
      String transactionId) async {
    try {
      final response =
          await ApiClient.get('/transactions/get-transaction/$transactionId');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ShowTransaction.fromJson(data['data']);
      } else {
        throw Exception('Failed to load transaction');
      }
    } catch (e, s) {
      print('Error fetching transaction: $e');
      print('Stack trace: $s');
      throw Exception('Error fetching transaction');
    }
  }
}
