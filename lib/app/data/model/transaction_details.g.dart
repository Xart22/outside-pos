// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_details.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTransactionDetailsCollection on Isar {
  IsarCollection<TransactionDetails> get transactionDetails =>
      this.collection();
}

const TransactionDetailsSchema = CollectionSchema(
  name: r'TransactionDetails',
  id: 2984382071110295881,
  properties: {
    r'menuId': PropertySchema(
      id: 0,
      name: r'menuId',
      type: IsarType.long,
    ),
    r'note': PropertySchema(
      id: 1,
      name: r'note',
      type: IsarType.long,
    ),
    r'quantity': PropertySchema(
      id: 2,
      name: r'quantity',
      type: IsarType.long,
    ),
    r'transactionId': PropertySchema(
      id: 3,
      name: r'transactionId',
      type: IsarType.long,
    )
  },
  estimateSize: _transactionDetailsEstimateSize,
  serialize: _transactionDetailsSerialize,
  deserialize: _transactionDetailsDeserialize,
  deserializeProp: _transactionDetailsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'transaction': LinkSchema(
      id: 6484993654222199543,
      name: r'transaction',
      target: r'Transactions',
      single: true,
    ),
    r'menu': LinkSchema(
      id: -3825764643102376670,
      name: r'menu',
      target: r'Menus',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _transactionDetailsGetId,
  getLinks: _transactionDetailsGetLinks,
  attach: _transactionDetailsAttach,
  version: '3.1.0+1',
);

int _transactionDetailsEstimateSize(
  TransactionDetails object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _transactionDetailsSerialize(
  TransactionDetails object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.menuId);
  writer.writeLong(offsets[1], object.note);
  writer.writeLong(offsets[2], object.quantity);
  writer.writeLong(offsets[3], object.transactionId);
}

TransactionDetails _transactionDetailsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TransactionDetails();
  object.id = id;
  object.menuId = reader.readLongOrNull(offsets[0]);
  object.note = reader.readLongOrNull(offsets[1]);
  object.quantity = reader.readLongOrNull(offsets[2]);
  object.transactionId = reader.readLongOrNull(offsets[3]);
  return object;
}

P _transactionDetailsDeserializeProp<P>(
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
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _transactionDetailsGetId(TransactionDetails object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _transactionDetailsGetLinks(
    TransactionDetails object) {
  return [object.transaction, object.menu];
}

void _transactionDetailsAttach(
    IsarCollection<dynamic> col, Id id, TransactionDetails object) {
  object.id = id;
  object.transaction
      .attach(col, col.isar.collection<Transactions>(), r'transaction', id);
  object.menu.attach(col, col.isar.collection<Menus>(), r'menu', id);
}

extension TransactionDetailsQueryWhereSort
    on QueryBuilder<TransactionDetails, TransactionDetails, QWhere> {
  QueryBuilder<TransactionDetails, TransactionDetails, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TransactionDetailsQueryWhere
    on QueryBuilder<TransactionDetails, TransactionDetails, QWhereClause> {
  QueryBuilder<TransactionDetails, TransactionDetails, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterWhereClause>
      idBetween(
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

extension TransactionDetailsQueryFilter
    on QueryBuilder<TransactionDetails, TransactionDetails, QFilterCondition> {
  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
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

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      idLessThan(
    Id value, {
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

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
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

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      menuIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'menuId',
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      menuIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'menuId',
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      menuIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'menuId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      menuIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'menuId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      menuIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'menuId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      menuIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'menuId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      noteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      noteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      noteEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      noteGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'note',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      noteLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'note',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      noteBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'note',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      quantityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quantity',
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      quantityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quantity',
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      quantityEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      quantityGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      quantityLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      quantityBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      transactionIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'transactionId',
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      transactionIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'transactionId',
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      transactionIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transactionId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      transactionIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transactionId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      transactionIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transactionId',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      transactionIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transactionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TransactionDetailsQueryObject
    on QueryBuilder<TransactionDetails, TransactionDetails, QFilterCondition> {}

extension TransactionDetailsQueryLinks
    on QueryBuilder<TransactionDetails, TransactionDetails, QFilterCondition> {
  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      transaction(FilterQuery<Transactions> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'transaction');
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      transactionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'transaction', 0, true, 0, true);
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      menu(FilterQuery<Menus> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'menu');
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterFilterCondition>
      menuIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'menu', 0, true, 0, true);
    });
  }
}

extension TransactionDetailsQuerySortBy
    on QueryBuilder<TransactionDetails, TransactionDetails, QSortBy> {
  QueryBuilder<TransactionDetails, TransactionDetails, QAfterSortBy>
      sortByMenuId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'menuId', Sort.asc);
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterSortBy>
      sortByMenuIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'menuId', Sort.desc);
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterSortBy>
      sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterSortBy>
      sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterSortBy>
      sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterSortBy>
      sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterSortBy>
      sortByTransactionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionId', Sort.asc);
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterSortBy>
      sortByTransactionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionId', Sort.desc);
    });
  }
}

extension TransactionDetailsQuerySortThenBy
    on QueryBuilder<TransactionDetails, TransactionDetails, QSortThenBy> {
  QueryBuilder<TransactionDetails, TransactionDetails, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterSortBy>
      thenByMenuId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'menuId', Sort.asc);
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterSortBy>
      thenByMenuIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'menuId', Sort.desc);
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterSortBy>
      thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterSortBy>
      thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterSortBy>
      thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterSortBy>
      thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterSortBy>
      thenByTransactionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionId', Sort.asc);
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QAfterSortBy>
      thenByTransactionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionId', Sort.desc);
    });
  }
}

extension TransactionDetailsQueryWhereDistinct
    on QueryBuilder<TransactionDetails, TransactionDetails, QDistinct> {
  QueryBuilder<TransactionDetails, TransactionDetails, QDistinct>
      distinctByMenuId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'menuId');
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QDistinct>
      distinctByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note');
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QDistinct>
      distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }

  QueryBuilder<TransactionDetails, TransactionDetails, QDistinct>
      distinctByTransactionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transactionId');
    });
  }
}

extension TransactionDetailsQueryProperty
    on QueryBuilder<TransactionDetails, TransactionDetails, QQueryProperty> {
  QueryBuilder<TransactionDetails, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TransactionDetails, int?, QQueryOperations> menuIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'menuId');
    });
  }

  QueryBuilder<TransactionDetails, int?, QQueryOperations> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<TransactionDetails, int?, QQueryOperations> quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }

  QueryBuilder<TransactionDetails, int?, QQueryOperations>
      transactionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transactionId');
    });
  }
}
