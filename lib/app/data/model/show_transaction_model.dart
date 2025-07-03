import 'dart:convert';

ShowTransaction showTransactionFromJson(String str) =>
    ShowTransaction.fromJson(json.decode(str));

String showTransactionToJson(ShowTransaction data) =>
    json.encode(data.toJson());

class ShowTransaction {
  final String orderNumber;
  final String customerName;
  final String orderDate;
  final String type;
  final int? tableNumber;
  final int subTotal;
  final int discount;
  final int total;
  final String paymentMethod;
  final int? cash;
  final int? change;
  final List<DataMenu> data;
  final String? paymentProof;

  ShowTransaction({
    required this.orderNumber,
    required this.orderDate,
    required this.type,
    required this.customerName,
    required this.tableNumber,
    required this.subTotal,
    required this.discount,
    required this.total,
    required this.paymentMethod,
    required this.cash,
    required this.change,
    required this.data,
    this.paymentProof,
  });

  factory ShowTransaction.fromJson(Map<String, dynamic> json) =>
      ShowTransaction(
        orderNumber: json["order_number"],
        orderDate: json["order_date"],
        type: json["type"],
        customerName: json["customer_name"],
        tableNumber: json["table_number"],
        subTotal: json["sub_total"],
        discount: json["discount"],
        total: json["total"],
        paymentMethod: json["payment_method"],
        cash: json["cash"],
        change: json["change"],
        data:
            List<DataMenu>.from(json["data"].map((x) => DataMenu.fromJson(x))),
        paymentProof: json["payment_proof"],
      );

  Map<String, dynamic> toJson() => {
        "order_number": orderNumber,
        "customer_name": customerName,
        "table_number": tableNumber,
        "sub_total": subTotal,
        "discount": discount,
        "total": total,
        "payment_method": paymentMethod,
        "cash": cash,
        "change": change,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataMenu {
  final String menu;
  final int quantity;
  final int basePrice;
  final int variantPrice;
  final int totalPrice;
  final List<Variant> variants;

  DataMenu({
    required this.menu,
    required this.quantity,
    required this.basePrice,
    required this.variantPrice,
    required this.totalPrice,
    required this.variants,
  });

  factory DataMenu.fromJson(Map<String, dynamic> json) => DataMenu(
        menu: json["menu"],
        quantity: json["quantity"],
        basePrice: json["base_price"],
        variantPrice: json["variant_price"],
        totalPrice: json["total_price"],
        variants: List<Variant>.from(
            json["variants"].map((x) => Variant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "menu": menu,
        "quantity": quantity,
        "base_price": basePrice,
        "variant_price": variantPrice,
        "total_price": totalPrice,
        "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
      };
}

class Variant {
  final String variantName;
  final String name;
  final int price;

  Variant({
    required this.variantName,
    required this.name,
    required this.price,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        variantName: json["variant_name"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "variant_name": variantName,
        "name": name,
        "price": price,
      };
}
