import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:pos_getx/app/data/model/user_model.dart';

Transaction transactionFromJson(String str) =>
    Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class TransactionList {
  final List<Transaction> transactions;
  final int cashDrawerStart;

  TransactionList({required this.transactions, required this.cashDrawerStart});

  factory TransactionList.fromJson(List<dynamic> json) {
    return TransactionList(
      transactions: json.map((i) => Transaction.fromJson(i)).toList(),
      cashDrawerStart: json[0]['cash_drawer_start'] ?? 0,
    );
  }
  factory TransactionList.fromJsonWithCashDrawer(
      List<dynamic> json, int cashDrawerStart) {
    return TransactionList(
      transactions: json.map((i) => Transaction.fromJson(i)).toList(),
      cashDrawerStart: cashDrawerStart,
    );
  }
  List<dynamic> toJson() {
    return transactions.map((transaction) => transaction.toJson()).toList();
  }
}

class Transaction {
  final int id;
  final String orderId;
  final int userId;
  final dynamic promoId;
  final String type;
  final String status;
  final int tableNumber;
  final String customerName;
  final int cash;
  final int change;
  final int discount;
  final int totalPrice;
  final String paymentMethod;
  final dynamic paymentStatus;
  final dynamic paymentProof;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;
  final dynamic promo;

  Transaction({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.promoId,
    required this.type,
    required this.status,
    required this.tableNumber,
    required this.customerName,
    required this.cash,
    required this.change,
    required this.discount,
    required this.totalPrice,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.paymentProof,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.promo,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        orderId: json["order_id"],
        userId: json["user_id"],
        promoId: json["promo_id"],
        type: json["type"],
        status: json["status"],
        tableNumber: json["table_number"],
        customerName: json["customer_name"],
        cash: json["cash"],
        change: json["change"],
        discount: json["discount"],
        totalPrice: json["total_price"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        paymentProof: json["payment_proof"],
        createdAt: DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(json["created_at"])
            .toLocal(),
        updatedAt: DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(json["updated_at"])
            .toLocal(),
        user: User.fromJson(json["user"]),
        promo: json["promo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "user_id": userId,
        "promo_id": promoId,
        "type": type,
        "status": status,
        "table_number": tableNumber,
        "customer_name": customerName,
        "cash": cash,
        "change": change,
        "discount": discount,
        "total_price": totalPrice,
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
        "payment_proof": paymentProof,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
        "promo": promo,
      };
}
