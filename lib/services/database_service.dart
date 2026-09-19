import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:farmayopin/models/item.dart';
import 'package:farmayopin/models/orden.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database_service.g.dart';

// 1. Tabla de Órdenes
class OrdenesTable extends Table {
  TextColumn get id => text()(); // Usamos String como ID según tu modelo
  DateTimeColumn get fechaCompletada => dateTime()();
  RealColumn get importeTotal => real()();

  @override
  Set<Column> get primaryKey => {id}; // Llave primaria explícita
}

// 2. Tabla de Items (Relacionada con Órdenes)
class ItemsTable extends Table {
  TextColumn get idProducto => text()();
  TextColumn get idOrden =>
      text().references(OrdenesTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get nombreProducto => text()();
  RealColumn get precio => real()();
  IntColumn get cantidad => integer()();
  TextColumn get emailUsuario => text()();
  DateTimeColumn get fechaCompletada => dateTime()();

  @override
  Set<Column> get primaryKey => {idProducto, idOrden}; // Llave primaria compuesta
}

// 3. Estructura de retorno para consultas combinadas
class OrdenConItems {
  final OrdenesTableData orden;
  final List<ItemsTableData> items;

  OrdenConItems({required this.orden, required this.items});
}

// 4. Base de Datos Central
@DriftDatabase(tables: [OrdenesTable, ItemsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // ====== NUEVO MÉTODO: GUARDAR ORDEN DESDE TU MODELO NATIVO ======
  Future<void> registrarNuevaOrden(Orden miOrden) async {
    final ordenCompanion = OrdenesTableCompanion.insert(
      id: miOrden.id,
      fechaCompletada: miOrden.fechaCompletada,
      importeTotal: miOrden.importeTotal,
    );

    final itemsCompanion = miOrden.misItems.map((item) {
      return ItemsTableCompanion.insert(
        idProducto: item.idProducto,
        idOrden: item.idOrden,
        nombreProducto: item.nombreProducto,
        precio: item.precio,
        cantidad: item.cantidad,
        emailUsuario: item.emailUsuario,
        fechaCompletada: item.fechaCompletada,
      );
    }).toList();

    // Llama a la transacción interna que ya tenías
    await guardarOrdenCompleta(ordenCompanion, itemsCompanion);
  }

  // ====== NUEVO MÉTODO: LEER ORDENES DIRECTO COMO TU MODELO NATIVO ======
  Future<List<Orden>> obtenerMisOrdenesLocales() async {
    // 1. Traemos la lista interna combinada de Drift
    final ordenes = await select(ordenesTable).get();
    final listaCompleta = <Orden>[];

    for (final ordenDb in ordenes) {
      // Buscamos los ítems de esta orden
      final itemsDb = await (select(
        itemsTable,
      )..where((t) => t.idOrden.equals(ordenDb.id))).get();

      // Mapeamos a tu clase Item
      final List<Item> listaDeItems = itemsDb.map((itemRow) {
        return Item(
          idProducto: itemRow.idProducto,
          idOrden: itemRow.idOrden,
          nombreProducto: itemRow.nombreProducto,
          precio: itemRow.precio,
          cantidad: itemRow.cantidad,
          emailUsuario: itemRow.emailUsuario,
          fechaCompletada: itemRow.fechaCompletada,
        );
      }).toList();

      // Mapeamos a tu clase Orden
      listaCompleta.add(
        Orden(
          id: ordenDb.id,
          fechaCompletada: ordenDb.fechaCompletada,
          importeTotal: ordenDb.importeTotal,
          misItems: listaDeItems,
        ),
      );
    }
    return listaCompleta;
  }

  // Insertar una Orden Completa con todos sus Items dentro de una transacción segura
  Future<void> guardarOrdenCompleta(
    OrdenesTableCompanion orden,
    List<ItemsTableCompanion> listaItems,
  ) async {
    await transaction(() async {
      // CORRECCIÓN: Agregamos "into(ordenesTable)" antes de .insertOnConflictUpdate
      await into(ordenesTable).insertOnConflictUpdate(orden);

      for (var item in listaItems) {
        // CORRECCIÓN: Agregamos "into(itemsTable)" antes de .insertOnConflictUpdate
        await into(itemsTable).insertOnConflictUpdate(item);
      }
    });
  }

  // Obtener todas las órdenes con sus respectivos ítems en tiempo real (Stream)
  Stream<List<OrdenConItems>> watchOrdenesConItems() {
    final ordenesStream = select(ordenesTable).watch();

    return ordenesStream.asyncMap((ordenes) async {
      final listaCompleta = <OrdenConItems>[];

      for (final orden in ordenes) {
        final queryItems = select(itemsTable)
          ..where((t) => t.idOrden.equals(orden.id));
        final items = await queryItems.get();

        listaCompleta.add(OrdenConItems(orden: orden, items: items));
      }

      return listaCompleta;
    });
  }

  // Dentro de tu class AppDatabase en database_service.dart

  Future<List<OrdenConItems>> obtenerTodasLasOrdenesRaw() async {
    final ordenes = await select(ordenesTable).get();
    final listaCompleta = <OrdenConItems>[];

    for (final orden in ordenes) {
      final items = await (select(
        itemsTable,
      )..where((t) => t.idOrden.equals(orden.id))).get();
      listaCompleta.add(OrdenConItems(orden: orden, items: items));
    }
    return listaCompleta;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
