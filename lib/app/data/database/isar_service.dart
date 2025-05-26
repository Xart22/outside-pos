import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pos_getx/app/data/model/categories.dart';
import 'package:pos_getx/app/data/model/menu_options.dart';
import 'package:pos_getx/app/data/model/menus.dart';
import 'package:pos_getx/app/data/model/promos.dart';
import 'package:pos_getx/app/data/model/settings.dart';
import 'package:pos_getx/app/data/model/transaction_detail_variants.dart';
import 'package:pos_getx/app/data/model/transaction_details.dart';
import 'package:pos_getx/app/data/model/transactions.dart';
import 'package:pos_getx/app/data/model/user.dart';
import 'package:pos_getx/app/data/model/variants.dart';
import 'package:pos_getx/app/data/model/variants_options.dart';

class IsarService {
  static late Isar isar;

  static Future<void> init() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [
          CategoriesSchema,
          MenuOptionsSchema,
          MenusSchema,
          PromosSchema,
          TransactionDetailVariantsSchema,
          TransactionDetailsSchema,
          TransactionsSchema,
          VariantsSchema,
          VariantsOptionsSchema,
          UserSchema,
          SettingsSchema
        ],
        directory: dir.path,
      );
      print("Isar initialized successfully at ${dir.path}");
    } catch (e) {
      print("Error initializing Isar: $e");
    }
  }
}
