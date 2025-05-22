import 'package:isar/isar.dart';

part 'transactions.g.dart';

@Collection()
class Transactions {
  Id? id;
  String? invoice;
  int? userId;
  int? promoId;
  String? type;
  String? status;
  int? tableNumber;
  String? customerName;
  int? cash;
  int? change;
  int? totalPrice;
  int? discount;
  String? paymentMethod;
  String? paymentProof;
  String? note;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
}
