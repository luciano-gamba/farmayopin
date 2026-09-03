import 'package:farmayopin/pages/noRol/registrar.dart';
import 'package:farmayopin/services/pocketbase_service.dart';
import 'package:farmayopin/widgets/glass_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FormLogIn extends StatefulWidget {
  const FormLogIn({super.key});

  @override
  State<FormLogIn> createState() => _FormLogInState();
}

class _FormLogInState extends State<FormLogIn> {
  final PocketBaseService pocketBaseService = PocketBaseService();

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _ingresar() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        final usuario = await pocketBaseService.iniciarSesion(
          email: _emailController.text, 
          password: _passwordController.text,
          );
          print('Bienvenido ${usuario.get<String>('name')}');
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Bienvenido ${usuario.get<String>('name')}'),
              backgroundColor: Colors.green,
            )
          );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al iniciar sesión'),
            backgroundColor: Colors.red,
          )
        );
        print ('Error al iniciar sesión: $e');
      } 
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // EMAIL
            const Text(
              'Email',
              style: TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'johndoe@gmail.com',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresá tu email';
                }

                if (!value.contains('@')) {
                  return 'Ingresá un email válido';
                }

                return null;
              },
            ),

            const SizedBox(height: 24),

            // CONTRASEÑA
            const Text(
              'Contraseña',
              style: TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Contraseña',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresá tu contraseña';
                }

                return null;
              },
            ),

            const SizedBox(height: 24),

            // BOTÓN INGRESAR
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _ingresar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E1E1E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Ingresar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // REGISTRO
            SizedBox(
              width: double.infinity,
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: '¿Aún no tienes cuenta?',
                      style: TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: 'Registrate',
                      style: const TextStyle(
                        color: Color(0xFFDC0000),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                      // 1. Agrega el recognizer para detectar el toque
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // 2. Aquí colocas la navegación a tu nueva página
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Registrar(),
                            ), // Reemplaza RegistroPage por tu vista
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
