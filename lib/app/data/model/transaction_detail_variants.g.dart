// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_detail_variants.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTransactionDetailVariantsCollection on Isar {
  IsarCollection<TransactionDetailVariants> get transactionDetailVariants =>
      this.collection();
}

const TransactionDetailVariantsSchema = CollectionSchema(
  name: r'TransactionDetailVariants',
  id: -1939940175893881961,
  properties: {
    r'transactionDetailId': PropertySchema(
      id: 0,
      name: r'transactionDetailId',
      type: IsarType.long,
    ),
    r'variantOptionsId': PropertySchema(
      id: 1,
      name: r'variantOptionsId',
      type: IsarType.long,
    )
  },
  estimateSize: _transactionDetailVariantsEstimateSize,
  serialize: _transactionDetailVariantsSerialize,
  deserialize: _transactionDetailVariantsDeserialize,
  deserializeProp: _transactionDetailVariantsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'variantOptions': LinkSchema(
      id: 2947112085675472986,
      name: r'variantOptions',
      target: r'VariantsOptions',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _transactionDetailVariantsGetId,
  getLinks: _transactionDetailVariantsGetLinks,
  attach: _transactionDetailVariantsAttach,
  version: '3.1.0+1',
);

int _transactionDetailVariantsEstimateSize(
  TransactionDetailVariants object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _transactionDetailVariantsSerialize(
  TransactionDetailVariants object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.transactionDetailId);
  writer.writeLong(offsets[1], object.variantOptionsId);
}

TransactionDetailVariants _transactionDetailVariantsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TransactionDetailVariants();
  object.id = id;
  object.transactionDetailId = reader.readLongOrNull(offsets[0]);
  object.variantOptionsId = reader.readLongOrNull(offsets[1]);
  return object;
}

P _transactionDetailVariantsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _transactionDetailVariantsGetId(TransactionDetailVariants object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _transactionDetailVariantsGetLinks(
    TransactionDetailVariants object) {
  return [object.variantOptions];
}

void _transactionDetailVariantsAttach(
    IsarCollection<dynamic> col, Id id, TransactionDetailVariants object) {
  object.id = id;
  object.variantOptions.attach(
      col, col.isar.collection<VariantsOptions>(), r'variantOptions', id);
}

extension TransactionDetailVariantsQueryWhereSort on QueryBuilder<
    TransactionDetailVariants, TransactionDetailVariants, QWhere> {
  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TransactionDetailVariantsQueryWhere on QueryBuilder<
    TransactionDetailVariants, TransactionDetailVariants, QWhereClause> {
  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TransactionDetailVariantsQueryFilter on QueryBuilder<
    TransactionDetailVariants, TransactionDetailVariants, QFilterCondition> {
  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> transactionDetailIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'transactionDetailId',
      ));
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> transactionDetailIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'transactionDetailId',
      ));
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> transactionDetailIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transactionDetailId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> transactionDetailIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transactionDetailId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> transactionDetailIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transactionDetailId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> transactionDetailIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transactionDetailId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> variantOptionsIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'variantOptionsId',
      ));
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> variantOptionsIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'variantOptionsId',
      ));
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> variantOptionsIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'variantOptionsId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> variantOptionsIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'variantOptionsId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> variantOptionsIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'variantOptionsId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> variantOptionsIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'variantOptionsId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TransactionDetailVariantsQueryObject on QueryBuilder<
    TransactionDetailVariants, TransactionDetailVariants, QFilterCondition> {}

extension TransactionDetailVariantsQueryLinks on QueryBuilder<
    TransactionDetailVariants, TransactionDetailVariants, QFilterCondition> {
  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> variantOptions(FilterQuery<VariantsOptions> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'variantOptions');
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterFilterCondition> variantOptionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'variantOptions', 0, true, 0, true);
    });
  }
}

extension TransactionDetailVariantsQuerySortBy on QueryBuilder<
    TransactionDetailVariants, TransactionDetailVariants, QSortBy> {
  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterSortBy> sortByTransactionDetailId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionDetailId', Sort.asc);
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterSortBy> sortByTransactionDetailIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionDetailId', Sort.desc);
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterSortBy> sortByVariantOptionsId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'variantOptionsId', Sort.asc);
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterSortBy> sortByVariantOptionsIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'variantOptionsId', Sort.desc);
    });
  }
}

extension TransactionDetailVariantsQuerySortThenBy on QueryBuilder<
    TransactionDetailVariants, TransactionDetailVariants, QSortThenBy> {
  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterSortBy> thenByTransactionDetailId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionDetailId', Sort.asc);
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterSortBy> thenByTransactionDetailIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionDetailId', Sort.desc);
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterSortBy> thenByVariantOptionsId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'variantOptionsId', Sort.asc);
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants,
      QAfterSortBy> thenByVariantOptionsIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'variantOptionsId', Sort.desc);
    });
  }
}

extension TransactionDetailVariantsQueryWhereDistinct on QueryBuilder<
    TransactionDetailVariants, TransactionDetailVariants, QDistinct> {
  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants, QDistinct>
      distinctByTransactionDetailId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transactionDetailId');
    });
  }

  QueryBuilder<TransactionDetailVariants, TransactionDetailVariants, QDistinct>
      distinctByVariantOptionsId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'variantOptionsId');
    });
  }
}

extension TransactionDetailVariantsQueryProperty on QueryBuilder<
    TransactionDetailVariants, TransactionDetailVariants, QQueryProperty> {
  QueryBuilder<TransactionDetailVariants, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TransactionDetailVariants, int?, QQueryOperations>
      transactionDetailIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transactionDetailId');
    });
  }

  QueryBuilder<TransactionDetailVariants, int?, QQueryOperations>
      variantOptionsIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'variantOptionsId');
    });
  }
}
