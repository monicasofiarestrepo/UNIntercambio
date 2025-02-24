import 'package:flutter/material.dart';
import 'package:un_intercambio/features/base_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    void _login() {
      // TODO: Lógica de inicio de sesión
    }

    void _goToHome() {
      Navigator.pushNamed(context, '/home');
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
              ElevatedButton(onPressed: _login, child: const Text('Ingresar')),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/recover'),
                child: const Text('¿Olvidaste tu contraseña?'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _goToHome,
                child: const Text('Ir al Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
