import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:un_intercambio/core/icon_column.dart';
import 'package:un_intercambio/core/option_card.dart';
import 'package:un_intercambio/features/base_page.dart';
import 'package:un_intercambio/core/theme.dart';

//AGREGAR RUTAS DE PÁGINAS

class Home extends StatelessWidget {
  const Home({super.key});

  String getCurrentTime() {
    return DateFormat('HH:mm').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backgroundImageRoute: 'assets/images/backgroundWithLogo.png',
      currentIndex: 0, // Índice de la barra de navegación para esta página
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Hora y estado de la red en la parte superior
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Hora en la esquina izquierda
                  Text(
                    getCurrentTime(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Iconos de señal, wifi y batería en la esquina derecha
                  const Row(
                    children: [
                      Icon(Icons.signal_cellular_alt, size: 25),
                      SizedBox(width: 6),
                      Icon(Icons.wifi, size: 25),
                      SizedBox(width: 6),
                      Icon(Icons.battery_full, size: 25),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            // Bienvenida y descripción de la app
            const Center(
              child: Column(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hola ',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: SystemColors.neutralDark,
                          ),
                        ),
                        TextSpan(
                          text: 'Luisa',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: SystemColors.primaryPrink,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Bienvenid@ a UNIntercambio, la página para que gestiones las convocatorias de movilidad en la universidad.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Banner de la app
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/banner.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: const BoxDecoration(
                        color: SystemColors.neutralLight,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      alignment: Alignment.center,
                      child: const Text(
                        'La app oficial de intercambios de la universidad',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Iconos de acceso rápido
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconColumn(
                    icon: Icons.article,
                    label: 'Convocatorias',
                    route: '/convocatorias'),
                IconColumn(
                  icon: Icons.folder,
                  label: 'Documentos',
                  route: '/',
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Opciones de la app
            Expanded(
              child: ListView(
                children: const [
                  OptionCard(
                    title: 'Calendario',
                    subtitle: 'Fechas relevantes de tus convocatorias',
                    icon: Icons.calendar_month,
                    route: '/calendar',
                  ),
                  OptionCard(
                    title: 'Conversor de divisas',
                    subtitle:
                        'Convierte monedas fácilmente para tu movilidad en convocatorias internacionales',
                    icon: Icons.monetization_on,
                    route: '/cambio-moneda',
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
