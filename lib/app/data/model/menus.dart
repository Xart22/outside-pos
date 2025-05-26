import 'package:isar/isar.dart';
import 'package:pos_getx/app/data/model/categories.dart';

part 'menus.g.dart';

@Collection()
class Menus {
  Id? id;
  int? categoryId;
  String? name;
  String? image;
  String? price;
  String? description;
  int? stock;
  bool? isActive;
  bool? isOnline;

  final categories = IsarLink<Categories>();
}
