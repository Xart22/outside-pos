import 'package:isar/isar.dart';
import 'package:pos_getx/app/data/model/variants_options.dart';

part 'transaction_detail_variants.g.dart';

@Collection()
class TransactionDetailVariants {
  Id? id;
  int? transactionDetailId;
  int? variantOptionsId;

  final variantOptions = IsarLink<VariantsOptions>();
}
