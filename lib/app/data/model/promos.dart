import 'package:isar/isar.dart';

part 'promos.g.dart';

@Collection()
class Promos {
  Id? id;
  String? name;
  String? code;
  String? type;
  int? value;
  int? minTransaction;
  int? maxDiscount;
  DateTime? startDate;
  DateTime? endDate;
  bool? isActive;
}
