import 'package:flutter/material.dart';
import 'package:un_intercambio/features/Convocatoria_page.dart';
import 'package:un_intercambio/features/calendar_page.dart';
import 'package:un_intercambio/features/chat_page.dart';
import 'package:un_intercambio/features/home_page.dart';
import 'package:un_intercambio/features/info_page.dart';
import 'package:un_intercambio/features/login_page.dart';
import 'package:un_intercambio/features/metric_page.dart';
import 'package:un_intercambio/features/profile_page.dart';
import 'package:un_intercambio/features/report_page.dart';
import 'package:un_intercambio/features/form_convocatoria_page.dart';


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
        '/metrics': (context) => const MetricPage(title: 'Métricas'),
        '/reports': (context) => const ReportPage(title: 'Reportes'),
        '/calendar': (context) => const CalendarPage(title: 'Calendario'),
        '/convocatorias': (context) => ConvocatoriaPage(title: 'Convocatorias'),
        '/formularioConvocatorias': (context) => FormularioConvocatoriaPage(),
      },
      home: const LoginPage(title: 'login'),
    );
  }
}
