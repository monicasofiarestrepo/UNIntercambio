import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:un_intercambio/core/icon_column.dart';
import 'package:un_intercambio/core/option_card.dart';
import 'package:un_intercambio/features/base_page.dart';
import 'package:un_intercambio/data/providers/usuario_provider.dart';

class HomePage extends ConsumerWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuarioAsync = ref.watch(usuarioProvider);

    return BasePage(
      backgroundImageRoute: 'assets/images/backgroundWithLogo.png',
      currentIndex: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 120),
            Center(
              child: usuarioAsync.when(
                data: (usuarios) {
                  if (usuarios.isEmpty) {
                    return const Text(
                      'Hola',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    );
                  }
                  final nombre = usuarios.first.nombre;
                  return Column(
                    children: [
                      Text(
                        'Hola $nombre',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Bienvenida a UNIntercambio, la página para que gestiones las convocatorias de movilidad en la universidad.',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => const Text(
                  'Error al cargar el usuario',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/banner.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconColumn(icon: Icons.assignment, label: 'Convocatorias', route: '/convocatorias'),
                IconColumn(icon: Icons.people, label: 'Evaluación', route: '/evaluation'),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  OptionCard(
                    title: 'Visita las métricas',
                    subtitle: 'Para ver los insights de las convocatorias',
                    icon: Icons.analytics,
                    route: '/metrics',
                  ),
                  OptionCard(
                    title: 'Calendario',
                    subtitle: 'Mantén al tanto de las fechas relevantes',
                    icon: Icons.calendar_month,
                    route: '/calendar',
                  ),
                  OptionCard(
                    title: 'Crea convocatorias',
                    subtitle: 'Para que los estudiantes estén informados',
                    icon: Icons.upload_file,
                    route: '/formularioConvocatorias',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
