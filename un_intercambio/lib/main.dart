import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';
import 'package:un_intercambio/core/global_variables.dart';
import 'package:un_intercambio/features/candidatos_page.dart';
import 'package:un_intercambio/features/convocatoria_page.dart';
import 'package:un_intercambio/features/convocatoria_conf_page.dart';
import 'package:un_intercambio/features/calendar_page.dart';
import 'package:un_intercambio/features/chat_page.dart';
import 'package:un_intercambio/features/formulario_postulacion_page.dart';
import 'package:un_intercambio/features/home_page.dart';
import 'package:un_intercambio/features/info_page.dart';
import 'package:un_intercambio/features/login_page.dart';
import 'package:un_intercambio/features/metric_page.dart';
import 'package:un_intercambio/features/profile_page.dart';
import 'package:un_intercambio/features/admin_profile_page.dart';
import 'package:un_intercambio/features/report_page.dart';
import 'package:un_intercambio/features/form_convocatoria_page.dart';
import 'package:un_intercambio/features/register_page.dart';
import 'package:un_intercambio/features/recover_account_page.dart';
import 'package:un_intercambio/data/services/auth_provider.dart';
import 'package:un_intercambio/features/student/cambio_moneda_page.dart';
import 'package:un_intercambio/features/student/convocatoria_estudiante_page.dart';
import 'package:un_intercambio/features/student/home_estudiante_page.dart';

void main() {
  runApp(
    const riverpod.ProviderScope(
      // 🔹 ProviderScope para Riverpod
      child: MyApp(),
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
          //'/home': (context) => const HomePage(title: 'UNintercambio Home'),
          //'/home-student': (context) => const Home(),
          //'/convocatorias-student': (context) => const ConvocatoriaEstudiantePage(),
          //'/profile': (context) => UserProfilePage(title: 'Perfil'),
          '/cambio-moneda': (context) => const CurrencyConverterScreen(),
          '/info': (context) => const InfoPage(title: 'Información'),
          '/chat': (context) => const ChatPage(title: 'Chat'),
          '/metrics': (context) => const MetricPage(title: 'Métricas'),
          '/reports': (context) => const ReportPage(title: 'Reportes'),
          '/calendar': (context) => const CalendarPage(title: 'Calendario'),
          '/convocatoriasConfig': (context) => const ConvocatoriaConfPage(title: 'Convocatorias'),
          '/formularioPostulacion': (context) => const PostulacionForm(tituloConvocatoria: '', nivelIdioma: '', descripcionConvocatoria: "", idConvocatoria: "",), 
          // Ruta para candidatos, que recibe el id de la convocatoria
          '/candidatos': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            final convocatoriaId = args['convocatoriaId'] as String;
            final convocatoriaNombre = args['convocatoriaNombre'] as String;
            return CandidatosPage(convocatoriaId: convocatoriaId, convocatoriaNombre: convocatoriaNombre);
          },



          //'/convocatorias': (context) => const ConvocatoriaPage(title: 'Convocatorias'),
          '/formularioConvocatorias': (context) =>
              const FormularioConvocatoriaPage(),

          '/home': (context) => riverpod.Consumer(
                builder: (context, ref, child) {
                  final isEstudiante = ref.watch(isEstudianteProvider);

                  return isEstudiante
                      ? const Home()
                      : const HomePage(title: 'UNintercambio Home');
                },
              ),
          '/convocatorias': (context) => riverpod.Consumer(
                builder: (context, ref, child) {
                  final isEstudiante = ref.watch(isEstudianteProvider);

                  return isEstudiante
                      ? const ConvocatoriaEstudiantePage()
                      : const ConvocatoriaPage(title: 'Convocatorias');
                },
              ),
          '/profile': (context) => riverpod.Consumer(
                builder: (context, ref, child) {
                  final isEstudiante = ref.watch(isEstudianteProvider);

                  return isEstudiante
                      ? UserProfilePage(title: 'Perfil')
                      : const AdminProfilePage(title: 'Perfil');
                },
              ),
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

    return authProvider.currentUser == null
        ? const LoginPage()
        : const HomePage(title: 'UNintercambio Home');
  }
}
