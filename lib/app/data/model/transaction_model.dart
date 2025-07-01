import 'dart:convert';

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
  final int? cash;
  final int? change;
  final int? discount;
  final int totalPrice;
  final String paymentMethod;
  final dynamic paymentStatus;
  final dynamic paymentProof;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;
  final dynamic promo;
  final List<Details> details = [];

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
        createdAt: DateTime.parse(json["created_at"]).toLocal(),
        updatedAt: DateTime.parse(json["updated_at"]).toLocal(),
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

Details detailsFromJson(String str) => Details.fromJson(json.decode(str));

String detailsToJson(Details data) => json.encode(data.toJson());

class Details {
  final int id;
  final int transactionId;
  final int menuId;
  final int quantity;
  final dynamic note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Menu menu;
  final List<DetailVariant> detailVariants;

  Details({
    required this.id,
    required this.transactionId,
    required this.menuId,
    required this.quantity,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.menu,
    required this.detailVariants,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"],
        transactionId: json["transaction_id"],
        menuId: json["menu_id"],
        quantity: json["quantity"],
        note: json["note"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        menu: Menu.fromJson(json["menu"]),
        detailVariants: List<DetailVariant>.from(
            json["detail_variants"].map((x) => DetailVariant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transaction_id": transactionId,
        "menu_id": menuId,
        "quantity": quantity,
        "note": note,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "menu": menu.toJson(),
        "detail_variants":
            List<dynamic>.from(detailVariants.map((x) => x.toJson())),
      };
}

class DetailVariant {
  final int transactionDetailId;
  final int variantOptionsId;
  final int variantId;
  final DateTime createdAt;
  final DateTime updatedAt;

  DetailVariant({
    required this.transactionDetailId,
    required this.variantOptionsId,
    required this.variantId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DetailVariant.fromJson(Map<String, dynamic> json) => DetailVariant(
        transactionDetailId: json["transaction_detail_id"],
        variantOptionsId: json["variant_options_id"],
        variantId: json["variant_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "transaction_detail_id": transactionDetailId,
        "variant_options_id": variantOptionsId,
        "variant_id": variantId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Menu {
  final int id;
  final String name;
  final int price;
  final String description;
  final String image;
  final String imageLocal;
  final int stock;
  final int isActive;
  final int isOnline;
  final Category category;
  final List<VariantElement> variants;

  Menu({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.imageLocal,
    required this.stock,
    required this.isActive,
    required this.isOnline,
    required this.category,
    required this.variants,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        image: json["image"],
        imageLocal: json["image_local"],
        stock: json["stock"],
        isActive: json["is_active"],
        isOnline: json["is_online"],
        category: Category.fromJson(json["category"]),
        variants: List<VariantElement>.from(
            json["variants"].map((x) => VariantElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "image": image,
        "image_local": imageLocal,
        "stock": stock,
        "is_active": isActive,
        "is_online": isOnline,
        "category": category.toJson(),
        "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
      };
}

class Category {
  final int id;
  final String name;
  final String icon;

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
      };
}

class VariantElement {
  final int id;
  final int position;
  final VariantVariant variant;

  VariantElement({
    required this.id,
    required this.position,
    required this.variant,
  });

  factory VariantElement.fromJson(Map<String, dynamic> json) => VariantElement(
        id: json["id"],
        position: json["position"],
        variant: VariantVariant.fromJson(json["variant"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "position": position,
        "variant": variant.toJson(),
      };
}

class VariantVariant {
  final int id;
  final String name;
  final int rulesMin;
  final int rulesMax;
  final List<Option> options;

  VariantVariant({
    required this.id,
    required this.name,
    required this.rulesMin,
    required this.rulesMax,
    required this.options,
  });

  factory VariantVariant.fromJson(Map<String, dynamic> json) => VariantVariant(
        id: json["id"],
        name: json["name"],
        rulesMin: json["rules_min"],
        rulesMax: json["rules_max"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rules_min": rulesMin,
        "rules_max": rulesMax,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
      };
}

class Option {
  final int id;
  final int variantId;
  final String name;
  final int price;
  final int position;

  Option({
    required this.id,
    required this.variantId,
    required this.name,
    required this.price,
    required this.position,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        variantId: json["variant_id"],
        name: json["name"],
        price: json["price"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "variant_id": variantId,
        "name": name,
        "price": price,
        "position": position,
      };
}
