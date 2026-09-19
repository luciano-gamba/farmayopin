import 'package:farmayopin/models/orden.dart';
import 'package:farmayopin/services/pocketbase_service.dart';
import 'package:farmayopin/widgets/historialCliente/history_header_cliente.dart';
import 'package:farmayopin/widgets/historialCliente/orden_history.dart';
import 'package:flutter/material.dart';

class PurchaseHistoryCliente extends StatefulWidget {
  const PurchaseHistoryCliente({super.key});

  @override
  State<PurchaseHistoryCliente> createState() => _PurchaseHistoryClienteState();
}

class _PurchaseHistoryClienteState extends State<PurchaseHistoryCliente> {
  final PocketBaseService pocketBaseService = PocketBaseService();

  List<Orden> misOrdenes = [];
  bool cargando = true;

  int? indiceExpandido = 0;

  @override
  void initState() {
    super.initState();
    cargarHistorial();
  }

  Future<void> cargarHistorial() async {
    try {
      final resultado = await pocketBaseService.obtenerMisOrdenes();

      setState(() {
        misOrdenes = resultado;
        cargando = false;
      });
    } catch (e) {
      print('Error al obtener historico del producto: $e');

      setState(() {
        cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          HistoryHeaderCliente(),
          const SizedBox(height: 20),
          cargando
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: cargarHistorial,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: misOrdenes.length,
                    itemBuilder: (context, index) {
                      return OrdenHistory(
                        orden: misOrdenes[index],
                        expandido: indiceExpandido == index,
                        onTap: () {
                          setState(() {
                            if (indiceExpandido == index) {
                              indiceExpandido = null;
                            } else {
                              indiceExpandido = index;
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
