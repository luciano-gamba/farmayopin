import 'package:farmayopin/models/item.dart';
import 'package:farmayopin/models/producto.dart';
import 'package:farmayopin/services/pocketbase_service.dart';
import 'package:farmayopin/widgets/items/history_header.dart';
import 'package:farmayopin/widgets/items/item_history.dart';
import 'package:flutter/material.dart';

class PurchaseHistory extends StatefulWidget{
  final Producto producto;

  const PurchaseHistory(
    {super.key,
    required this.producto}
  );

  @override
  State<PurchaseHistory> createState() => _PurchaseHistoryState();
}
class _PurchaseHistoryState extends State<PurchaseHistory> {
  final PocketBaseService pocketBaseService = PocketBaseService();

  List<Item> misItems = [];
  bool cargando = true;

  int? indiceExpandido = 0;
  
  @override
  void initState() {
    super.initState();
    cargarHistorial();
  }

  Future<void> cargarHistorial() async {
    try {
      final resultado = await pocketBaseService.obtenerItemsProducto(idProducto: widget.producto.id);

      setState(() {
        misItems = resultado;
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
          HistoryHeader(
            nombreProducto: widget.producto.nombre,
          ),
          
          const SizedBox(height: 20),

          cargando
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: cargarHistorial,
                  child: ListView.builder(
                    shrinkWrap: true,
                     physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: misItems.length,
                    itemBuilder: (context, index) {
                      return ItemHistory(
                        item: misItems[index],
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