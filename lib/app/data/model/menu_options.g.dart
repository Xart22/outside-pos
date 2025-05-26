// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_options.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMenuOptionsCollection on Isar {
  IsarCollection<MenuOptions> get menuOptions => this.collection();
}

const MenuOptionsSchema = CollectionSchema(
  name: r'MenuOptions',
  id: -2841090682380435314,
  properties: {
    r'menuId': PropertySchema(
      id: 0,
      name: r'menuId',
      type: IsarType.long,
    ),
    r'variantId': PropertySchema(
      id: 1,
      name: r'variantId',
      type: IsarType.long,
    )
  },
  estimateSize: _menuOptionsEstimateSize,
  serialize: _menuOptionsSerialize,
  deserialize: _menuOptionsDeserialize,
  deserializeProp: _menuOptionsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'menu': LinkSchema(
      id: 8508504314320525706,
      name: r'menu',
      target: r'Menus',
      single: true,
    ),
    r'variants': LinkSchema(
      id: -6654047072112597452,
      name: r'variants',
      target: r'Variants',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _menuOptionsGetId,
  getLinks: _menuOptionsGetLinks,
  attach: _menuOptionsAttach,
  version: '3.1.0+1',
);

int _menuOptionsEstimateSize(
  MenuOptions object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _menuOptionsSerialize(
  MenuOptions object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.menuId);
  writer.writeLong(offsets[1], object.variantId);
}

MenuOptions _menuOptionsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MenuOptions();
  object.id = id;
  object.menuId = reader.readLongOrNull(offsets[0]);
  object.variantId = reader.readLongOrNull(offsets[1]);
  return object;
}

P _menuOptionsDeserializeProp<P>(
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

Id _menuOptionsGetId(MenuOptions object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _menuOptionsGetLinks(MenuOptions object) {
  return [object.menu, object.variants];
}

void _menuOptionsAttach(
    IsarCollection<dynamic> col, Id id, MenuOptions object) {
  object.id = id;
  object.menu.attach(col, col.isar.collection<Menus>(), r'menu', id);
  object.variants.attach(col, col.isar.collection<Variants>(), r'variants', id);
}

extension MenuOptionsQueryWhereSort
    on QueryBuilder<MenuOptions, MenuOptions, QWhere> {
  QueryBuilder<MenuOptions, MenuOptions, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MenuOptionsQueryWhere
    on QueryBuilder<MenuOptions, MenuOptions, QWhereClause> {
  QueryBuilder<MenuOptions, MenuOptions, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<MenuOptions, MenuOptions, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterWhereClause> idBetween(
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

extension MenuOptionsQueryFilter
    on QueryBuilder<MenuOptions, MenuOptions, QFilterCondition> {
  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition> menuIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'menuId',
      ));
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition>
      menuIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'menuId',
      ));
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition> menuIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'menuId',
        value: value,
      ));
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition>
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

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition> menuIdLessThan(
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

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition> menuIdBetween(
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

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition>
      variantIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'variantId',
      ));
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition>
      variantIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'variantId',
      ));
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition>
      variantIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'variantId',
        value: value,
      ));
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition>
      variantIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'variantId',
        value: value,
      ));
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition>
      variantIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'variantId',
        value: value,
      ));
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition>
      variantIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'variantId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MenuOptionsQueryObject
    on QueryBuilder<MenuOptions, MenuOptions, QFilterCondition> {}

extension MenuOptionsQueryLinks
    on QueryBuilder<MenuOptions, MenuOptions, QFilterCondition> {
  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition> menu(
      FilterQuery<Menus> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'menu');
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition> menuIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'menu', 0, true, 0, true);
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition> variants(
      FilterQuery<Variants> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'variants');
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterFilterCondition>
      variantsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'variants', 0, true, 0, true);
    });
  }
}

extension MenuOptionsQuerySortBy
    on QueryBuilder<MenuOptions, MenuOptions, QSortBy> {
  QueryBuilder<MenuOptions, MenuOptions, QAfterSortBy> sortByMenuId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'menuId', Sort.asc);
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterSortBy> sortByMenuIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'menuId', Sort.desc);
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterSortBy> sortByVariantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'variantId', Sort.asc);
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterSortBy> sortByVariantIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'variantId', Sort.desc);
    });
  }
}

extension MenuOptionsQuerySortThenBy
    on QueryBuilder<MenuOptions, MenuOptions, QSortThenBy> {
  QueryBuilder<MenuOptions, MenuOptions, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterSortBy> thenByMenuId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'menuId', Sort.asc);
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterSortBy> thenByMenuIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'menuId', Sort.desc);
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterSortBy> thenByVariantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'variantId', Sort.asc);
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QAfterSortBy> thenByVariantIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'variantId', Sort.desc);
    });
  }
}

extension MenuOptionsQueryWhereDistinct
    on QueryBuilder<MenuOptions, MenuOptions, QDistinct> {
  QueryBuilder<MenuOptions, MenuOptions, QDistinct> distinctByMenuId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'menuId');
    });
  }

  QueryBuilder<MenuOptions, MenuOptions, QDistinct> distinctByVariantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'variantId');
    });
  }
}

extension MenuOptionsQueryProperty
    on QueryBuilder<MenuOptions, MenuOptions, QQueryProperty> {
  QueryBuilder<MenuOptions, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MenuOptions, int?, QQueryOperations> menuIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'menuId');
    });
  }

  QueryBuilder<MenuOptions, int?, QQueryOperations> variantIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'variantId');
    });
  }
}
