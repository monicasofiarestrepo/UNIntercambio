import 'package:flutter/material.dart';
import 'package:un_intercambio/features/base_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    void _register() {
      // TODO: Lógica de registro
    }

    return BasePage(
      showBottomNavBar: false, // No muestra el BottomNavBar en esta página
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Correo electrónico'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _register, child: const Text('Registrarse')),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: const Text('¿Ya tienes una cuenta? Inicia sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
