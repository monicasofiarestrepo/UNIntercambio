import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';
import 'package:un_intercambio/features/convocatoria_page.dart';
import 'package:un_intercambio/features/calendar_page.dart';
import 'package:un_intercambio/features/chat_page.dart';
import 'package:un_intercambio/features/home_page.dart';
import 'package:un_intercambio/features/info_page.dart';
import 'package:un_intercambio/features/login_page.dart';
import 'package:un_intercambio/features/metric_page.dart';
import 'package:un_intercambio/features/profile_page.dart';
import 'package:un_intercambio/features/report_page.dart';
import 'package:un_intercambio/features/form_convocatoria_page.dart';
import 'package:un_intercambio/features/register_page.dart';
import 'package:un_intercambio/features/recover_account_page.dart';
import 'package:un_intercambio/data/services/auth_provider.dart';
import 'package:un_intercambio/features/student/home_estudiante_page.dart';

void main() {
  runApp(
    const riverpod.ProviderScope( // 🔹 ProviderScope para Riverpod
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'UNintercambio',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthWrapper(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(title: "Registro"),
          '/recover': (context) => const RecoverAccountPage(),
          '/home': (context) => const HomePage(title: 'UNintercambio Home'),
          '/home-student': (context) => const Home(),
          '/info': (context) => const InfoPage(title: 'Información'),
          '/chat': (context) => const ChatPage(title: 'Chat'),
          '/profile': (context) => const UserProfilePage(title: 'Perfil'),
          '/metrics': (context) => const MetricPage(title: 'Métricas'),
          '/reports': (context) => const ReportPage(title: 'Reportes'),
          '/calendar': (context) => const CalendarPage(title: 'Calendario'),
          '/convocatorias': (context) => const ConvocatoriaPage(title: 'Convocatorias'),
          '/formularioConvocatorias': (context) => const FormularioConvocatoriaPage(),
        },
      ),
    );
  }
}

/// Widget para verificar si el usuario está autenticado
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return authProvider.currentUser == null ? const LoginPage() : const HomePage(title: 'UNintercambio Home');
  }
}
