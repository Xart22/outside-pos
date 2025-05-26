import 'package:isar/isar.dart';
import 'package:pos_getx/app/data/model/menus.dart';
import 'package:pos_getx/app/data/model/variants.dart';

part 'menu_options.g.dart';

@Collection()
class MenuOptions {
  Id? id;
  int? menuId;
  int? variantId;

  final menu = IsarLink<Menus>();
  final variants = IsarLink<Variants>();
}
