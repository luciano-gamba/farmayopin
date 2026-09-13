import 'dart:io';
import 'package:farmayopin/pages/cliente/listar_productos.dart';
import 'package:farmayopin/services/pocketbase_service.dart';
import 'package:farmayopin/widgets/formularios/form_input_decoration.dart';
import 'package:farmayopin/widgets/formularios/image_picker_field.dart';
import 'package:farmayopin/widgets/glass_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class FormNewProduct extends StatefulWidget {
  const FormNewProduct({super.key});
  

  @override
  State<FormNewProduct> createState() => _FormNewProductState();
}

class _FormNewProductState extends State<FormNewProduct> {
  final PocketBaseService pocketBaseService = PocketBaseService();
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _precioController = TextEditingController();
  final _stockController = TextEditingController();
  final _detalleController = TextEditingController();

  File? _imagenSeleccionada;
  bool _guardando = false;

  Future<void> _seleccionarImagen() async {
    final picker = ImagePicker();

    final imagen = await picker.pickImage(source: ImageSource.gallery);

    if (!mounted) return;

    if (imagen != null) {
      final archivo = File(imagen.path);
      final tamanio = await archivo.length();

      if (tamanio > 5 * 1024 * 1024) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('La imagen no puede superar los 5 MB'),
          ),
        );

        return;
      }
      setState(() {
        _imagenSeleccionada = File(imagen.path);
      });
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _precioController.dispose();
    _stockController.dispose();
    _detalleController.dispose();
    super.dispose();
  }

  Future<void> _guardarProducto() async {
    if(_guardando) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_imagenSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes seleccionar una imagen')),
      );
      return;
    }
    
    setState(() {
      _guardando = true;
    });

    try {
      final producto = await pocketBaseService.nuevoProducto(
        nombre: _nombreController.text.trim(),
        precio: double.parse(_precioController.text.replaceAll(',', '.')),
        stock: int.parse(_stockController.text),
        imagenProducto: _imagenSeleccionada!,
        descripcion: _detalleController.text.trim(),
      );

      print('Producto creado: ${producto.id}');
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ListarProductos()),
      );
    } catch (e) {
      print('ERROR AL CREAR PRODUCTO: $e');
      if (!mounted) return;

      setState(() {
        _guardando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al guardar el producto')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34),
          child: GlassCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen
                ImagePickerField(
                  imagen: _imagenSeleccionada,
                  onSeleccionar: _seleccionarImagen,
                ),

                const SizedBox(height: 16),

                const Text(
                  'Nombre',
                  style: TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _nombreController,
                  decoration: FormInputDecoration.campo(
                    hintText: 'Nombre del producto',
                  ),
                  maxLength: 100,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'El nombre del producto es requerido';
                    }

                    if (value.trim().length > 100) {
                      return 'El nombre no puede superar los 100 caracteres';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 12),

                const Text(
                  'Precio',
                  style: TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _precioController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: FormInputDecoration.campo(
                    hintText: '0,00',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*[.,]?\d{0,2}'),
                    ),
                  ],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'El precio del producto es requerido';
                    }
                    final precioTexto = value.replaceAll(',', '.');
                    final precio = double.tryParse(precioTexto);

                    if (precio == null) {
                      return 'El precio debe ser un número válido';
                    }

                    if (precio <= 0) {
                      return 'El precio debe ser mayor a 0';
                    }

                    if (precio > 1000000) {
                      return 'El precio no puede superar \$1.000.000';
                    }

                    if (precioTexto.contains('.') && precioTexto.split('.')[1].length > 2) {
                      return 'El precio puede tener como máximo 2 decimales';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 12),

                const Text(
                  'Stock',
                  style: TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _stockController,
                  keyboardType: TextInputType.number,
                  decoration: FormInputDecoration.campo(
                    hintText: 'Cantidad disponible',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'El stock del producto es requerido';
                    }
                    
                    final stock = int.tryParse(value);

                    if (stock == null) {
                      return 'El stock debe ser un número entero';
                    }

                    if (stock < 0) {
                      return 'El stock no puede ser negativo';
                    }

                    if (stock > 999999) {
                      return 'El stock es demasiado grande';
                    }

                    return null;
                  }
                ),

                const SizedBox(height: 12),

                const Text(
                  'Detalle',
                  style: TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _detalleController,
                  maxLines: 4,
                  maxLength: 500,
                  decoration: FormInputDecoration.campo(
                    hintText: 'Descripción del producto',
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ListarProductos(),
                            ),
                          );
                        },
                        child: const Text('Cancelar'),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: _guardando ? null : _guardarProducto,
                        child: _guardando
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Guardar Producto'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
