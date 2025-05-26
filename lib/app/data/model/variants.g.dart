// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variants.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVariantsCollection on Isar {
  IsarCollection<Variants> get variants => this.collection();
}

const VariantsSchema = CollectionSchema(
  name: r'Variants',
  id: 200048624294401514,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    ),
    r'rulesMax': PropertySchema(
      id: 1,
      name: r'rulesMax',
      type: IsarType.long,
    ),
    r'rulesMin': PropertySchema(
      id: 2,
      name: r'rulesMin',
      type: IsarType.long,
    )
  },
  estimateSize: _variantsEstimateSize,
  serialize: _variantsSerialize,
  deserialize: _variantsDeserialize,
  deserializeProp: _variantsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'variantOptions': LinkSchema(
      id: 8726573072062215589,
      name: r'variantOptions',
      target: r'VariantsOptions',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _variantsGetId,
  getLinks: _variantsGetLinks,
  attach: _variantsAttach,
  version: '3.1.0+1',
);

int _variantsEstimateSize(
  Variants object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _variantsSerialize(
  Variants object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
  writer.writeLong(offsets[1], object.rulesMax);
  writer.writeLong(offsets[2], object.rulesMin);
}

Variants _variantsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Variants();
  object.id = id;
  object.name = reader.readStringOrNull(offsets[0]);
  object.rulesMax = reader.readLongOrNull(offsets[1]);
  object.rulesMin = reader.readLongOrNull(offsets[2]);
  return object;
}

P _variantsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _variantsGetId(Variants object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _variantsGetLinks(Variants object) {
  return [object.variantOptions];
}

void _variantsAttach(IsarCollection<dynamic> col, Id id, Variants object) {
  object.id = id;
  object.variantOptions.attach(
      col, col.isar.collection<VariantsOptions>(), r'variantOptions', id);
}

extension VariantsQueryWhereSort on QueryBuilder<Variants, Variants, QWhere> {
  QueryBuilder<Variants, Variants, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VariantsQueryWhere on QueryBuilder<Variants, Variants, QWhereClause> {
  QueryBuilder<Variants, Variants, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Variants, Variants, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Variants, Variants, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Variants, Variants, QAfterWhereClause> idBetween(
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

extension VariantsQueryFilter
    on QueryBuilder<Variants, Variants, QFilterCondition> {
  QueryBuilder<Variants, Variants, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Variants, Variants, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Variants, Variants, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Variants, Variants, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> rulesMaxIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rulesMax',
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> rulesMaxIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rulesMax',
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> rulesMaxEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rulesMax',
        value: value,
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> rulesMaxGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rulesMax',
        value: value,
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> rulesMaxLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rulesMax',
        value: value,
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> rulesMaxBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rulesMax',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> rulesMinIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rulesMin',
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> rulesMinIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rulesMin',
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> rulesMinEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rulesMin',
        value: value,
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> rulesMinGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rulesMin',
        value: value,
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> rulesMinLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rulesMin',
        value: value,
      ));
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition> rulesMinBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rulesMin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension VariantsQueryObject
    on QueryBuilder<Variants, Variants, QFilterCondition> {}

extension VariantsQueryLinks
    on QueryBuilder<Variants, Variants, QFilterCondition> {
  QueryBuilder<Variants, Variants, QAfterFilterCondition> variantOptions(
      FilterQuery<VariantsOptions> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'variantOptions');
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition>
      variantOptionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'variantOptions', length, true, length, true);
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition>
      variantOptionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'variantOptions', 0, true, 0, true);
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition>
      variantOptionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'variantOptions', 0, false, 999999, true);
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition>
      variantOptionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'variantOptions', 0, true, length, include);
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition>
      variantOptionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'variantOptions', length, include, 999999, true);
    });
  }

  QueryBuilder<Variants, Variants, QAfterFilterCondition>
      variantOptionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'variantOptions', lower, includeLower, upper, includeUpper);
    });
  }
}

extension VariantsQuerySortBy on QueryBuilder<Variants, Variants, QSortBy> {
  QueryBuilder<Variants, Variants, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Variants, Variants, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Variants, Variants, QAfterSortBy> sortByRulesMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rulesMax', Sort.asc);
    });
  }

  QueryBuilder<Variants, Variants, QAfterSortBy> sortByRulesMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rulesMax', Sort.desc);
    });
  }

  QueryBuilder<Variants, Variants, QAfterSortBy> sortByRulesMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rulesMin', Sort.asc);
    });
  }

  QueryBuilder<Variants, Variants, QAfterSortBy> sortByRulesMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rulesMin', Sort.desc);
    });
  }
}

extension VariantsQuerySortThenBy
    on QueryBuilder<Variants, Variants, QSortThenBy> {
  QueryBuilder<Variants, Variants, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Variants, Variants, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Variants, Variants, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Variants, Variants, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Variants, Variants, QAfterSortBy> thenByRulesMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rulesMax', Sort.asc);
    });
  }

  QueryBuilder<Variants, Variants, QAfterSortBy> thenByRulesMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rulesMax', Sort.desc);
    });
  }

  QueryBuilder<Variants, Variants, QAfterSortBy> thenByRulesMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rulesMin', Sort.asc);
    });
  }

  QueryBuilder<Variants, Variants, QAfterSortBy> thenByRulesMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rulesMin', Sort.desc);
    });
  }
}

extension VariantsQueryWhereDistinct
    on QueryBuilder<Variants, Variants, QDistinct> {
  QueryBuilder<Variants, Variants, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Variants, Variants, QDistinct> distinctByRulesMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rulesMax');
    });
  }

  QueryBuilder<Variants, Variants, QDistinct> distinctByRulesMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rulesMin');
    });
  }
}

extension VariantsQueryProperty
    on QueryBuilder<Variants, Variants, QQueryProperty> {
  QueryBuilder<Variants, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Variants, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Variants, int?, QQueryOperations> rulesMaxProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rulesMax');
    });
  }

  QueryBuilder<Variants, int?, QQueryOperations> rulesMinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rulesMin');
    });
  }
}
