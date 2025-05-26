import 'package:isar/isar.dart';

part 'settings.g.dart';

@Collection()
class Settings {
  Id? id;

  @Index(unique: true)
  String? key;

  String? value;
}
