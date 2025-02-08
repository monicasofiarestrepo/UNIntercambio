import 'package:flutter/material.dart';
import 'package:un_intercambio/screens/home_admin_screen.dart'; // Pantalla principal
import 'package:un_intercambio/core/unintercambio_custom_icons.dart'; // Íconos personalizados

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UNIntercambio',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        useMaterial3: true,
      ),
      home: const HomeScreen(), // Nueva pantalla principal
    );
  }
}
