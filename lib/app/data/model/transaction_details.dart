import 'package:isar/isar.dart';

part 'transaction_details.g.dart';

@Collection()
class TransactionDetails {
  Id id = Isar.autoIncrement;
  int? transactionId;
  int? menuId;
  int? quantity;
  int? note;
}
