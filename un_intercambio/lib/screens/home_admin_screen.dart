import 'package:flutter/material.dart';
import '../core/icon_column.dart';
import '../core/option_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Stack(
              children: [
                // Fondo decorativo
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -50,
                          left: -40,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFE1F5FE),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          right: -30,
                          child: Container(
                            width: 75,
                            height: 75,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFFEBEE),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 100,
                          left: 100,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFD7F0F7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Contenido del encabezado
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.menu, color: Colors.black),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 20),
                          Image.asset('assets/logo.png', height: 40),
                          const SizedBox(width: 20),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications, color: Colors.black),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
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
                  image: AssetImage('assets/banner.png'),
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
                  ),
                  OptionCard(
                    title: 'Calendario',
                    subtitle: 'Mantén al tanto de las fechas relevantes',
                  ),
                  OptionCard(
                    title: 'Sube documentos',
                    subtitle: 'Para que los estudiantes estén informados',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.document_scanner_outlined), label: 'Convocatorias'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
