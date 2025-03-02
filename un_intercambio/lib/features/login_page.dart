import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:un_intercambio/core/global_variables.dart';
import 'package:un_intercambio/features/base_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _emailError =
          _emailController.text.isEmpty ? 'Este campo es obligatorio' : null;
      _passwordError =
          _passwordController.text.isEmpty ? 'Este campo es obligatorio' : null;
    });

    if (_emailError != null || _passwordError != null) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final Uri url = Uri.parse(
        'https://backend-devmovil.onrender.com/personas/buscar?correo=${_emailController.text}');

    try {
      final response = await http.get(url);

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.isNotEmpty) {
          final String emailFromDB = data['correo'];
          final String passwordFromDB = data['contrasena'];
          final String userType = data['tipoUsuario'];

          if (emailFromDB == _emailController.text &&
              passwordFromDB == _passwordController.text) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Inicio de sesión exitoso')),
            );

            // guardar el email en variables globales
            ref.read(emailUserProvider.notifier).state = emailFromDB;

            // Redirigir según el tipo de usuario
            if (userType == 'admin') {
              Navigator.pushNamed(context, '/home');
            } else if (userType == 'student') {
              Navigator.pushNamed(context, '/home');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tipo de usuario no reconocido')),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Correo o contraseña inválidos')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Correo o contraseña inválidos')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error en la autenticación')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de conexión: $e')),
      );
    }
  }

  void _goToRegister() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backgroundImageRoute: 'assets/images/backgroundWithLogo.png',
      showBottomNavBar: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  errorText: _emailError,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  errorText: _passwordError,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      child: const Text('Ingresar'),
                    ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _goToRegister,
                child: const Text('Crear estudiante'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/recover'),
                child: const Text('¿Olvidaste tu contraseña?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
