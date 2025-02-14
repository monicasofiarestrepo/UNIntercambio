import 'package:flutter/material.dart';
import 'package:un_intercambio/features/widgets/bottom_nav_bar.dart';
import 'package:un_intercambio/core/icon_column.dart';
import 'package:un_intercambio/core/option_card.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.contain,
              ),
            ),
          ),
          // hina: Aquí se inserta el contenido de `HomeScreen`
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 120),
                Center(
                  child: Column(
                    children: const [
                      Text(
                        'Hola Luisa',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Bienvenida a UNIntercambio, la página para que gestiones las convocatorias de movilidad en la universidad.',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    IconColumn(icon: Icons.assignment, label: 'Convocatorias'),
                    IconColumn(icon: Icons.people, label: 'Evaluación'),
                    IconColumn(icon: Icons.bar_chart, label: 'Reportes'),
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
                      ),
                      OptionCard(
                        title: 'Calendario',
                        subtitle: 'Mantén al tanto de las fechas relevantes',
                        icon: Icons.calendar_month,
                      ),
                      OptionCard(
                        title: 'Sube documentos',
                        subtitle: 'Para que los estudiantes estén informados',
                        icon: Icons.upload_file,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
