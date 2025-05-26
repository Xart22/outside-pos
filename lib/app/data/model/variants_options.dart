import 'package:isar/isar.dart';
import 'package:pos_getx/app/data/model/variants.dart';

part 'variants_options.g.dart';

@Collection()
class VariantsOptions {
  Id? id;
  int? variantId;
  String? name;
  String? price;

  final variants = IsarLink<Variants>();
}
