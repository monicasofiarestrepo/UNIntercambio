import 'package:flutter/material.dart';
import 'package:un_intercambio/features/chat_page.dart';
import 'package:un_intercambio/features/home_page.dart';
import 'package:un_intercambio/features/info_page.dart';
import 'package:un_intercambio/features/login_page.dart';
import 'package:un_intercambio/features/profile_page.dart';
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
        '/home': (context) => const HomePage(title: 'UNintercambio home'),
        '/info': (context) => const InfoPage(title: 'Información'),
        '/chat': (context) => const ChatPage(title: 'Chat'),
        '/profile': (context) => const UserProfilePage(title: 'Perfil'),

      },
      home: const LoginPage(title: 'login'),
    );
  }
}
