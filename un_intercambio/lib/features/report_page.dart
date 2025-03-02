import 'package:flutter/material.dart';
import 'package:un_intercambio/features/widgets/bottom_nav_bar.dart';

class ReportPage extends StatelessWidget {
  final String title;

  const ReportPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.teal,
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reportes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Accede a los reportes de desempeño y estadísticas relacionadas.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            // Agrega widgets o gráficos específicos aquí según el diseño
          ],
        ),
      ),
    );
  }
}
