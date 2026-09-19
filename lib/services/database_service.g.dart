// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_service.dart';

// ignore_for_file: type=lint
class $OrdenesTableTable extends OrdenesTable
    with TableInfo<$OrdenesTableTable, OrdenesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdenesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaCompletadaMeta = const VerificationMeta(
    'fechaCompletada',
  );
  @override
  late final GeneratedColumn<DateTime> fechaCompletada =
      GeneratedColumn<DateTime>(
        'fecha_completada',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _importeTotalMeta = const VerificationMeta(
    'importeTotal',
  );
  @override
  late final GeneratedColumn<double> importeTotal = GeneratedColumn<double>(
    'importe_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, fechaCompletada, importeTotal];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ordenes_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrdenesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('fecha_completada')) {
      context.handle(
        _fechaCompletadaMeta,
        fechaCompletada.isAcceptableOrUnknown(
          data['fecha_completada']!,
          _fechaCompletadaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaCompletadaMeta);
    }
    if (data.containsKey('importe_total')) {
      context.handle(
        _importeTotalMeta,
        importeTotal.isAcceptableOrUnknown(
          data['importe_total']!,
          _importeTotalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_importeTotalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrdenesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrdenesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fechaCompletada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_completada'],
      )!,
      importeTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}importe_total'],
      )!,
    );
  }

  @override
  $OrdenesTableTable createAlias(String alias) {
    return $OrdenesTableTable(attachedDatabase, alias);
  }
}

class OrdenesTableData extends DataClass
    implements Insertable<OrdenesTableData> {
  final String id;
  final DateTime fechaCompletada;
  final double importeTotal;
  const OrdenesTableData({
    required this.id,
    required this.fechaCompletada,
    required this.importeTotal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['fecha_completada'] = Variable<DateTime>(fechaCompletada);
    map['importe_total'] = Variable<double>(importeTotal);
    return map;
  }

  OrdenesTableCompanion toCompanion(bool nullToAbsent) {
    return OrdenesTableCompanion(
      id: Value(id),
      fechaCompletada: Value(fechaCompletada),
      importeTotal: Value(importeTotal),
    );
  }

  factory OrdenesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrdenesTableData(
      id: serializer.fromJson<String>(json['id']),
      fechaCompletada: serializer.fromJson<DateTime>(json['fechaCompletada']),
      importeTotal: serializer.fromJson<double>(json['importeTotal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fechaCompletada': serializer.toJson<DateTime>(fechaCompletada),
      'importeTotal': serializer.toJson<double>(importeTotal),
    };
  }

  OrdenesTableData copyWith({
    String? id,
    DateTime? fechaCompletada,
    double? importeTotal,
  }) => OrdenesTableData(
    id: id ?? this.id,
    fechaCompletada: fechaCompletada ?? this.fechaCompletada,
    importeTotal: importeTotal ?? this.importeTotal,
  );
  OrdenesTableData copyWithCompanion(OrdenesTableCompanion data) {
    return OrdenesTableData(
      id: data.id.present ? data.id.value : this.id,
      fechaCompletada: data.fechaCompletada.present
          ? data.fechaCompletada.value
          : this.fechaCompletada,
      importeTotal: data.importeTotal.present
          ? data.importeTotal.value
          : this.importeTotal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrdenesTableData(')
          ..write('id: $id, ')
          ..write('fechaCompletada: $fechaCompletada, ')
          ..write('importeTotal: $importeTotal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fechaCompletada, importeTotal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrdenesTableData &&
          other.id == this.id &&
          other.fechaCompletada == this.fechaCompletada &&
          other.importeTotal == this.importeTotal);
}

class OrdenesTableCompanion extends UpdateCompanion<OrdenesTableData> {
  final Value<String> id;
  final Value<DateTime> fechaCompletada;
  final Value<double> importeTotal;
  final Value<int> rowid;
  const OrdenesTableCompanion({
    this.id = const Value.absent(),
    this.fechaCompletada = const Value.absent(),
    this.importeTotal = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrdenesTableCompanion.insert({
    required String id,
    required DateTime fechaCompletada,
    required double importeTotal,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fechaCompletada = Value(fechaCompletada),
       importeTotal = Value(importeTotal);
  static Insertable<OrdenesTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? fechaCompletada,
    Expression<double>? importeTotal,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fechaCompletada != null) 'fecha_completada': fechaCompletada,
      if (importeTotal != null) 'importe_total': importeTotal,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrdenesTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? fechaCompletada,
    Value<double>? importeTotal,
    Value<int>? rowid,
  }) {
    return OrdenesTableCompanion(
      id: id ?? this.id,
      fechaCompletada: fechaCompletada ?? this.fechaCompletada,
      importeTotal: importeTotal ?? this.importeTotal,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fechaCompletada.present) {
      map['fecha_completada'] = Variable<DateTime>(fechaCompletada.value);
    }
    if (importeTotal.present) {
      map['importe_total'] = Variable<double>(importeTotal.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdenesTableCompanion(')
          ..write('id: $id, ')
          ..write('fechaCompletada: $fechaCompletada, ')
          ..write('importeTotal: $importeTotal, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ItemsTableTable extends ItemsTable
    with TableInfo<$ItemsTableTable, ItemsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idProductoMeta = const VerificationMeta(
    'idProducto',
  );
  @override
  late final GeneratedColumn<String> idProducto = GeneratedColumn<String>(
    'id_producto',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idOrdenMeta = const VerificationMeta(
    'idOrden',
  );
  @override
  late final GeneratedColumn<String> idOrden = GeneratedColumn<String>(
    'id_orden',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ordenes_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nombreProductoMeta = const VerificationMeta(
    'nombreProducto',
  );
  @override
  late final GeneratedColumn<String> nombreProducto = GeneratedColumn<String>(
    'nombre_producto',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioMeta = const VerificationMeta('precio');
  @override
  late final GeneratedColumn<double> precio = GeneratedColumn<double>(
    'precio',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<int> cantidad = GeneratedColumn<int>(
    'cantidad',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailUsuarioMeta = const VerificationMeta(
    'emailUsuario',
  );
  @override
  late final GeneratedColumn<String> emailUsuario = GeneratedColumn<String>(
    'email_usuario',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaCompletadaMeta = const VerificationMeta(
    'fechaCompletada',
  );
  @override
  late final GeneratedColumn<DateTime> fechaCompletada =
      GeneratedColumn<DateTime>(
        'fecha_completada',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    idProducto,
    idOrden,
    nombreProducto,
    precio,
    cantidad,
    emailUsuario,
    fechaCompletada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'items_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ItemsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_producto')) {
      context.handle(
        _idProductoMeta,
        idProducto.isAcceptableOrUnknown(data['id_producto']!, _idProductoMeta),
      );
    } else if (isInserting) {
      context.missing(_idProductoMeta);
    }
    if (data.containsKey('id_orden')) {
      context.handle(
        _idOrdenMeta,
        idOrden.isAcceptableOrUnknown(data['id_orden']!, _idOrdenMeta),
      );
    } else if (isInserting) {
      context.missing(_idOrdenMeta);
    }
    if (data.containsKey('nombre_producto')) {
      context.handle(
        _nombreProductoMeta,
        nombreProducto.isAcceptableOrUnknown(
          data['nombre_producto']!,
          _nombreProductoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nombreProductoMeta);
    }
    if (data.containsKey('precio')) {
      context.handle(
        _precioMeta,
        precio.isAcceptableOrUnknown(data['precio']!, _precioMeta),
      );
    } else if (isInserting) {
      context.missing(_precioMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('email_usuario')) {
      context.handle(
        _emailUsuarioMeta,
        emailUsuario.isAcceptableOrUnknown(
          data['email_usuario']!,
          _emailUsuarioMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_emailUsuarioMeta);
    }
    if (data.containsKey('fecha_completada')) {
      context.handle(
        _fechaCompletadaMeta,
        fechaCompletada.isAcceptableOrUnknown(
          data['fecha_completada']!,
          _fechaCompletadaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaCompletadaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idProducto, idOrden};
  @override
  ItemsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemsTableData(
      idProducto: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_producto'],
      )!,
      idOrden: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_orden'],
      )!,
      nombreProducto: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre_producto'],
      )!,
      precio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}precio'],
      )!,
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cantidad'],
      )!,
      emailUsuario: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email_usuario'],
      )!,
      fechaCompletada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_completada'],
      )!,
    );
  }

  @override
  $ItemsTableTable createAlias(String alias) {
    return $ItemsTableTable(attachedDatabase, alias);
  }
}

class ItemsTableData extends DataClass implements Insertable<ItemsTableData> {
  final String idProducto;
  final String idOrden;
  final String nombreProducto;
  final double precio;
  final int cantidad;
  final String emailUsuario;
  final DateTime fechaCompletada;
  const ItemsTableData({
    required this.idProducto,
    required this.idOrden,
    required this.nombreProducto,
    required this.precio,
    required this.cantidad,
    required this.emailUsuario,
    required this.fechaCompletada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_producto'] = Variable<String>(idProducto);
    map['id_orden'] = Variable<String>(idOrden);
    map['nombre_producto'] = Variable<String>(nombreProducto);
    map['precio'] = Variable<double>(precio);
    map['cantidad'] = Variable<int>(cantidad);
    map['email_usuario'] = Variable<String>(emailUsuario);
    map['fecha_completada'] = Variable<DateTime>(fechaCompletada);
    return map;
  }

  ItemsTableCompanion toCompanion(bool nullToAbsent) {
    return ItemsTableCompanion(
      idProducto: Value(idProducto),
      idOrden: Value(idOrden),
      nombreProducto: Value(nombreProducto),
      precio: Value(precio),
      cantidad: Value(cantidad),
      emailUsuario: Value(emailUsuario),
      fechaCompletada: Value(fechaCompletada),
    );
  }

  factory ItemsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemsTableData(
      idProducto: serializer.fromJson<String>(json['idProducto']),
      idOrden: serializer.fromJson<String>(json['idOrden']),
      nombreProducto: serializer.fromJson<String>(json['nombreProducto']),
      precio: serializer.fromJson<double>(json['precio']),
      cantidad: serializer.fromJson<int>(json['cantidad']),
      emailUsuario: serializer.fromJson<String>(json['emailUsuario']),
      fechaCompletada: serializer.fromJson<DateTime>(json['fechaCompletada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idProducto': serializer.toJson<String>(idProducto),
      'idOrden': serializer.toJson<String>(idOrden),
      'nombreProducto': serializer.toJson<String>(nombreProducto),
      'precio': serializer.toJson<double>(precio),
      'cantidad': serializer.toJson<int>(cantidad),
      'emailUsuario': serializer.toJson<String>(emailUsuario),
      'fechaCompletada': serializer.toJson<DateTime>(fechaCompletada),
    };
  }

  ItemsTableData copyWith({
    String? idProducto,
    String? idOrden,
    String? nombreProducto,
    double? precio,
    int? cantidad,
    String? emailUsuario,
    DateTime? fechaCompletada,
  }) => ItemsTableData(
    idProducto: idProducto ?? this.idProducto,
    idOrden: idOrden ?? this.idOrden,
    nombreProducto: nombreProducto ?? this.nombreProducto,
    precio: precio ?? this.precio,
    cantidad: cantidad ?? this.cantidad,
    emailUsuario: emailUsuario ?? this.emailUsuario,
    fechaCompletada: fechaCompletada ?? this.fechaCompletada,
  );
  ItemsTableData copyWithCompanion(ItemsTableCompanion data) {
    return ItemsTableData(
      idProducto: data.idProducto.present
          ? data.idProducto.value
          : this.idProducto,
      idOrden: data.idOrden.present ? data.idOrden.value : this.idOrden,
      nombreProducto: data.nombreProducto.present
          ? data.nombreProducto.value
          : this.nombreProducto,
      precio: data.precio.present ? data.precio.value : this.precio,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      emailUsuario: data.emailUsuario.present
          ? data.emailUsuario.value
          : this.emailUsuario,
      fechaCompletada: data.fechaCompletada.present
          ? data.fechaCompletada.value
          : this.fechaCompletada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemsTableData(')
          ..write('idProducto: $idProducto, ')
          ..write('idOrden: $idOrden, ')
          ..write('nombreProducto: $nombreProducto, ')
          ..write('precio: $precio, ')
          ..write('cantidad: $cantidad, ')
          ..write('emailUsuario: $emailUsuario, ')
          ..write('fechaCompletada: $fechaCompletada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    idProducto,
    idOrden,
    nombreProducto,
    precio,
    cantidad,
    emailUsuario,
    fechaCompletada,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemsTableData &&
          other.idProducto == this.idProducto &&
          other.idOrden == this.idOrden &&
          other.nombreProducto == this.nombreProducto &&
          other.precio == this.precio &&
          other.cantidad == this.cantidad &&
          other.emailUsuario == this.emailUsuario &&
          other.fechaCompletada == this.fechaCompletada);
}

class ItemsTableCompanion extends UpdateCompanion<ItemsTableData> {
  final Value<String> idProducto;
  final Value<String> idOrden;
  final Value<String> nombreProducto;
  final Value<double> precio;
  final Value<int> cantidad;
  final Value<String> emailUsuario;
  final Value<DateTime> fechaCompletada;
  final Value<int> rowid;
  const ItemsTableCompanion({
    this.idProducto = const Value.absent(),
    this.idOrden = const Value.absent(),
    this.nombreProducto = const Value.absent(),
    this.precio = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.emailUsuario = const Value.absent(),
    this.fechaCompletada = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItemsTableCompanion.insert({
    required String idProducto,
    required String idOrden,
    required String nombreProducto,
    required double precio,
    required int cantidad,
    required String emailUsuario,
    required DateTime fechaCompletada,
    this.rowid = const Value.absent(),
  }) : idProducto = Value(idProducto),
       idOrden = Value(idOrden),
       nombreProducto = Value(nombreProducto),
       precio = Value(precio),
       cantidad = Value(cantidad),
       emailUsuario = Value(emailUsuario),
       fechaCompletada = Value(fechaCompletada);
  static Insertable<ItemsTableData> custom({
    Expression<String>? idProducto,
    Expression<String>? idOrden,
    Expression<String>? nombreProducto,
    Expression<double>? precio,
    Expression<int>? cantidad,
    Expression<String>? emailUsuario,
    Expression<DateTime>? fechaCompletada,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (idProducto != null) 'id_producto': idProducto,
      if (idOrden != null) 'id_orden': idOrden,
      if (nombreProducto != null) 'nombre_producto': nombreProducto,
      if (precio != null) 'precio': precio,
      if (cantidad != null) 'cantidad': cantidad,
      if (emailUsuario != null) 'email_usuario': emailUsuario,
      if (fechaCompletada != null) 'fecha_completada': fechaCompletada,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItemsTableCompanion copyWith({
    Value<String>? idProducto,
    Value<String>? idOrden,
    Value<String>? nombreProducto,
    Value<double>? precio,
    Value<int>? cantidad,
    Value<String>? emailUsuario,
    Value<DateTime>? fechaCompletada,
    Value<int>? rowid,
  }) {
    return ItemsTableCompanion(
      idProducto: idProducto ?? this.idProducto,
      idOrden: idOrden ?? this.idOrden,
      nombreProducto: nombreProducto ?? this.nombreProducto,
      precio: precio ?? this.precio,
      cantidad: cantidad ?? this.cantidad,
      emailUsuario: emailUsuario ?? this.emailUsuario,
      fechaCompletada: fechaCompletada ?? this.fechaCompletada,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idProducto.present) {
      map['id_producto'] = Variable<String>(idProducto.value);
    }
    if (idOrden.present) {
      map['id_orden'] = Variable<String>(idOrden.value);
    }
    if (nombreProducto.present) {
      map['nombre_producto'] = Variable<String>(nombreProducto.value);
    }
    if (precio.present) {
      map['precio'] = Variable<double>(precio.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<int>(cantidad.value);
    }
    if (emailUsuario.present) {
      map['email_usuario'] = Variable<String>(emailUsuario.value);
    }
    if (fechaCompletada.present) {
      map['fecha_completada'] = Variable<DateTime>(fechaCompletada.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsTableCompanion(')
          ..write('idProducto: $idProducto, ')
          ..write('idOrden: $idOrden, ')
          ..write('nombreProducto: $nombreProducto, ')
          ..write('precio: $precio, ')
          ..write('cantidad: $cantidad, ')
          ..write('emailUsuario: $emailUsuario, ')
          ..write('fechaCompletada: $fechaCompletada, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $OrdenesTableTable ordenesTable = $OrdenesTableTable(this);
  late final $ItemsTableTable itemsTable = $ItemsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    ordenesTable,
    itemsTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'ordenes_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('items_table', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$OrdenesTableTableCreateCompanionBuilder =
    OrdenesTableCompanion Function({
      required String id,
      required DateTime fechaCompletada,
      required double importeTotal,
      Value<int> rowid,
    });
typedef $$OrdenesTableTableUpdateCompanionBuilder =
    OrdenesTableCompanion Function({
      Value<String> id,
      Value<DateTime> fechaCompletada,
      Value<double> importeTotal,
      Value<int> rowid,
    });

final class $$OrdenesTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $OrdenesTableTable, OrdenesTableData> {
  $$OrdenesTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ItemsTableTable, List<ItemsTableData>>
  _itemsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.itemsTable,
    aliasName: 'ordenes_table__id__items_table__id_orden',
  );

  $$ItemsTableTableProcessedTableManager get itemsTableRefs {
    final manager = $$ItemsTableTableTableManager(
      $_db,
      $_db.itemsTable,
    ).filter((f) => f.idOrden.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_itemsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$OrdenesTableTableFilterComposer
    extends Composer<_$AppDatabase, $OrdenesTableTable> {
  $$OrdenesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaCompletada => $composableBuilder(
    column: $table.fechaCompletada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get importeTotal => $composableBuilder(
    column: $table.importeTotal,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> itemsTableRefs(
    Expression<bool> Function($$ItemsTableTableFilterComposer f) f,
  ) {
    final $$ItemsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itemsTable,
      getReferencedColumn: (t) => t.idOrden,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableTableFilterComposer(
            $db: $db,
            $table: $db.itemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdenesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdenesTableTable> {
  $$OrdenesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaCompletada => $composableBuilder(
    column: $table.fechaCompletada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get importeTotal => $composableBuilder(
    column: $table.importeTotal,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrdenesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdenesTableTable> {
  $$OrdenesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaCompletada => $composableBuilder(
    column: $table.fechaCompletada,
    builder: (column) => column,
  );

  GeneratedColumn<double> get importeTotal => $composableBuilder(
    column: $table.importeTotal,
    builder: (column) => column,
  );

  Expression<T> itemsTableRefs<T extends Object>(
    Expression<T> Function($$ItemsTableTableAnnotationComposer a) f,
  ) {
    final $$ItemsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itemsTable,
      getReferencedColumn: (t) => t.idOrden,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.itemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdenesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrdenesTableTable,
          OrdenesTableData,
          $$OrdenesTableTableFilterComposer,
          $$OrdenesTableTableOrderingComposer,
          $$OrdenesTableTableAnnotationComposer,
          $$OrdenesTableTableCreateCompanionBuilder,
          $$OrdenesTableTableUpdateCompanionBuilder,
          (OrdenesTableData, $$OrdenesTableTableReferences),
          OrdenesTableData,
          PrefetchHooks Function({bool itemsTableRefs})
        > {
  $$OrdenesTableTableTableManager(_$AppDatabase db, $OrdenesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdenesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdenesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdenesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> fechaCompletada = const Value.absent(),
                Value<double> importeTotal = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrdenesTableCompanion(
                id: id,
                fechaCompletada: fechaCompletada,
                importeTotal: importeTotal,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime fechaCompletada,
                required double importeTotal,
                Value<int> rowid = const Value.absent(),
              }) => OrdenesTableCompanion.insert(
                id: id,
                fechaCompletada: fechaCompletada,
                importeTotal: importeTotal,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$OrdenesTableTable, OrdenesTableData>(table),
                  $$OrdenesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({itemsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (itemsTableRefs) db.itemsTable],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (itemsTableRefs)
                    await $_getPrefetchedData<
                      OrdenesTableData,
                      $OrdenesTableTable,
                      ItemsTableData
                    >(
                      currentTable: table,
                      referencedTable: $$OrdenesTableTableReferences
                          ._itemsTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$OrdenesTableTableReferences(
                            db,
                            table,
                            p0,
                          ).itemsTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.idOrden == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$OrdenesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrdenesTableTable,
      OrdenesTableData,
      $$OrdenesTableTableFilterComposer,
      $$OrdenesTableTableOrderingComposer,
      $$OrdenesTableTableAnnotationComposer,
      $$OrdenesTableTableCreateCompanionBuilder,
      $$OrdenesTableTableUpdateCompanionBuilder,
      (OrdenesTableData, $$OrdenesTableTableReferences),
      OrdenesTableData,
      PrefetchHooks Function({bool itemsTableRefs})
    >;
typedef $$ItemsTableTableCreateCompanionBuilder = ItemsTableCompanion Function({
  required String idProducto,
  required String idOrden,
  required String nombreProducto,
  required double precio,
  required int cantidad,
  required String emailUsuario,
  required DateTime fechaCompletada,
  Value<int> rowid,
});
typedef $$ItemsTableTableUpdateCompanionBuilder = ItemsTableCompanion Function({
  Value<String> idProducto,
  Value<String> idOrden,
  Value<String> nombreProducto,
  Value<double> precio,
  Value<int> cantidad,
  Value<String> emailUsuario,
  Value<DateTime> fechaCompletada,
  Value<int> rowid,
});

final class $$ItemsTableTableReferences
    extends BaseReferences<_$AppDatabase, $ItemsTableTable, ItemsTableData> {
  $$ItemsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrdenesTableTable _idOrdenTable(_$AppDatabase db) =>
      db.ordenesTable.createAlias('items_table__id_orden__ordenes_table__id');

  $$OrdenesTableTableProcessedTableManager get idOrden {
    final $_column = $_itemColumn<String>('id_orden')!;

    final manager = $$OrdenesTableTableTableManager(
      $_db,
      $_db.ordenesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idOrdenTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ItemsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ItemsTableTable> {
  $$ItemsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get idProducto => $composableBuilder(
    column: $table.idProducto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombreProducto => $composableBuilder(
    column: $table.nombreProducto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get precio => $composableBuilder(
    column: $table.precio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emailUsuario => $composableBuilder(
    column: $table.emailUsuario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaCompletada => $composableBuilder(
    column: $table.fechaCompletada,
    builder: (column) => ColumnFilters(column),
  );

  $$OrdenesTableTableFilterComposer get idOrden {
    final $$OrdenesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idOrden,
      referencedTable: $db.ordenesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableTableFilterComposer(
            $db: $db,
            $table: $db.ordenesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemsTableTable> {
  $$ItemsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get idProducto => $composableBuilder(
    column: $table.idProducto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombreProducto => $composableBuilder(
    column: $table.nombreProducto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get precio => $composableBuilder(
    column: $table.precio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emailUsuario => $composableBuilder(
    column: $table.emailUsuario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaCompletada => $composableBuilder(
    column: $table.fechaCompletada,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrdenesTableTableOrderingComposer get idOrden {
    final $$OrdenesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idOrden,
      referencedTable: $db.ordenesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableTableOrderingComposer(
            $db: $db,
            $table: $db.ordenesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemsTableTable> {
  $$ItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get idProducto => $composableBuilder(
    column: $table.idProducto,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nombreProducto => $composableBuilder(
    column: $table.nombreProducto,
    builder: (column) => column,
  );

  GeneratedColumn<double> get precio =>
      $composableBuilder(column: $table.precio, builder: (column) => column);

  GeneratedColumn<int> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<String> get emailUsuario => $composableBuilder(
    column: $table.emailUsuario,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaCompletada => $composableBuilder(
    column: $table.fechaCompletada,
    builder: (column) => column,
  );

  $$OrdenesTableTableAnnotationComposer get idOrden {
    final $$OrdenesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idOrden,
      referencedTable: $db.ordenesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.ordenesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItemsTableTable,
          ItemsTableData,
          $$ItemsTableTableFilterComposer,
          $$ItemsTableTableOrderingComposer,
          $$ItemsTableTableAnnotationComposer,
          $$ItemsTableTableCreateCompanionBuilder,
          $$ItemsTableTableUpdateCompanionBuilder,
          (ItemsTableData, $$ItemsTableTableReferences),
          ItemsTableData,
          PrefetchHooks Function({bool idOrden})
        > {
  $$ItemsTableTableTableManager(_$AppDatabase db, $ItemsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> idProducto = const Value.absent(),
                Value<String> idOrden = const Value.absent(),
                Value<String> nombreProducto = const Value.absent(),
                Value<double> precio = const Value.absent(),
                Value<int> cantidad = const Value.absent(),
                Value<String> emailUsuario = const Value.absent(),
                Value<DateTime> fechaCompletada = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ItemsTableCompanion(
                idProducto: idProducto,
                idOrden: idOrden,
                nombreProducto: nombreProducto,
                precio: precio,
                cantidad: cantidad,
                emailUsuario: emailUsuario,
                fechaCompletada: fechaCompletada,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String idProducto,
                required String idOrden,
                required String nombreProducto,
                required double precio,
                required int cantidad,
                required String emailUsuario,
                required DateTime fechaCompletada,
                Value<int> rowid = const Value.absent(),
              }) => ItemsTableCompanion.insert(
                idProducto: idProducto,
                idOrden: idOrden,
                nombreProducto: nombreProducto,
                precio: precio,
                cantidad: cantidad,
                emailUsuario: emailUsuario,
                fechaCompletada: fechaCompletada,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ItemsTableTable, ItemsTableData>(table),
                  $$ItemsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({idOrden = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (idOrden) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.idOrden,
                        referencedTable: $$ItemsTableTableReferences
                            ._idOrdenTable(db),
                        referencedColumn: $$ItemsTableTableReferences
                            ._idOrdenTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ItemsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItemsTableTable,
      ItemsTableData,
      $$ItemsTableTableFilterComposer,
      $$ItemsTableTableOrderingComposer,
      $$ItemsTableTableAnnotationComposer,
      $$ItemsTableTableCreateCompanionBuilder,
      $$ItemsTableTableUpdateCompanionBuilder,
      (ItemsTableData, $$ItemsTableTableReferences),
      ItemsTableData,
      PrefetchHooks Function({bool idOrden})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$OrdenesTableTableTableManager get ordenesTable =>
      $$OrdenesTableTableTableManager(_db, _db.ordenesTable);
  $$ItemsTableTableTableManager get itemsTable =>
      $$ItemsTableTableTableManager(_db, _db.itemsTable);
}
