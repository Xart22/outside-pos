import 'package:isar/isar.dart';
import 'package:pos_getx/app/data/model/variants_options.dart';

part 'variants.g.dart';

@Collection()
class Variants {
  Id id = Isar.autoIncrement;
  String? name;
  int? rulesMin;
  int? rulesMax;

  final variantOptions = IsarLinks<VariantsOptions>();
}
