import 'package:flutter/material.dart';
import 'package:un_intercambio/features/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UNintercambio',
      initialRoute: '/',
      routes: {
        '/home': (context) => const MyHomePage(title: 'UNintercambio'),

      },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}