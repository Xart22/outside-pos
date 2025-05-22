import 'package:isar/isar.dart';

part 'menus.g.dart';

@Collection()
class Menus {
  Id? id;
  String? name;
  String? image;
  String? price;
  String? description;
  int? categoryId;
  int? stock;
  bool? isActive;
  bool? isOnline;
}
