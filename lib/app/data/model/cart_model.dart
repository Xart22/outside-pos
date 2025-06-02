import 'package:get/get.dart';

class CartItem {
  final int menuId;
  RxInt qty = 0.obs;
  final Map<int, int> options;
  final String note;

  int getQty() => qty.value;
  void setQty(int val) => qty.value = val;

  CartItem({
    required this.menuId,
    required this.qty,
    required this.options,
    required this.note,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      menuId: json['menuId'],
      qty: json['qty'],
      options: Map<int, int>.from(json['options']),
      note: json['note'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menuId': menuId,
      'qty': qty,
      'options': options,
      'note': note,
    };
  }
}
