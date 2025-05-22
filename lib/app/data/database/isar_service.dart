import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pos_getx/app/data/model/categories.dart';
import 'package:pos_getx/app/data/model/menu_options.dart';
import 'package:pos_getx/app/data/model/menus.dart';
import 'package:pos_getx/app/data/model/promos.dart';
import 'package:pos_getx/app/data/model/transaction_detail_variants.dart';
import 'package:pos_getx/app/data/model/transaction_details.dart';
import 'package:pos_getx/app/data/model/transactions.dart';
import 'package:pos_getx/app/data/model/variants.dart';
import 'package:pos_getx/app/data/model/variants_options.dart';

class IsarService {
  static late Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        CategoriesSchema,
        TransactionDetailsSchema,
        VariantsSchema,
        TransactionDetailVariantsSchema,
        PromosSchema,
        MenusSchema,
        TransactionsSchema,
        VariantOptionsSchema,
        MenuOptionsSchema,
      ],
      directory: dir.path,
    );
  }
}
