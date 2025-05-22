import 'package:isar/isar.dart';

part 'variants.g.dart';

@Collection()
class Variants {
  Id id = Isar.autoIncrement;
  String? name;
  int? rulesMin;
  int? rulesMax;
}
