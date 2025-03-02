import 'package:flutter/material.dart';
import 'package:un_intercambio/features/base_page.dart';

class RecoverAccountPage extends StatelessWidget {
  const RecoverAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();

    void _recoverPassword() {
      // TODO: Lógica de recuperación de contraseña
    }

    return BasePage(
      showBottomNavBar: false, // No muestra el BottomNavBar en esta página
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Recuperar Cuenta",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Correo electrónico'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _recoverPassword, child: const Text('Recuperar Contraseña')),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: const Text('Volver al inicio de sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
