import 'package:isar/isar.dart';
import 'package:pos_getx/app/data/model/menus.dart';
import 'package:pos_getx/app/data/model/transactions.dart';

part 'transaction_details.g.dart';

@Collection()
class TransactionDetails {
  Id id = Isar.autoIncrement;
  int? transactionId;
  int? menuId;
  int? quantity;
  int? note;

  final transaction = IsarLink<Transactions>();
  final menu = IsarLink<Menus>();
}
