import 'package:flutter/material.dart';
import 'package:un_intercambio/core/icon_column.dart';
import 'package:un_intercambio/core/option_card.dart';
import 'package:un_intercambio/features/base_page.dart';

//TODO revisar si se pueden utilizar widgets o colores ya creados
//TODO Añadir lo de que depende de si usuario o admin

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backgroundImageRoute: 'assets/images/backgroundWithLogo.png',
      currentIndex: 0, // Índice de la barra de navegación para esta página
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 120),
            Center(
              child: Column(
                children: const [
                  Text(
                    'Hola Patricia',
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
                IconColumn(icon: Icons.assignment, label: 'Convocatorias', route: '/convocatorias'),
                IconColumn(icon: Icons.people, label: 'Evaluación', route: '/evaluation'),
                IconColumn(icon: Icons.bar_chart, label: 'Reportes', route: '/reports'),
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
