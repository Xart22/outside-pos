import 'package:isar/isar.dart';
import 'package:pos_getx/app/data/model/transactions.dart';

part 'user.g.dart';

@Collection()
class User {
  Id? id;
  String? name;
  int? nip;
  String? role;
  String? password;

  final transactions = IsarLink<Transactions>();
}
