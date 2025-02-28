import 'package:flutter/material.dart';
import 'package:un_intercambio/features/widgets/bottom_nav_bar.dart';

class BasePage extends StatelessWidget {
  final int? currentIndex;
  final Widget child;
  final bool showBottomNavBar;

  const BasePage({
    Key? key,
    this.currentIndex,
    required this.child,
    this.showBottomNavBar = true, // Por defecto se muestra el BottomNavBar
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: showBottomNavBar && currentIndex != null
          ? BottomNavBar(currentIndex: currentIndex!)
          : null, // No muestra el navbar si showBottomNavBar es false
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover, // Cambiado de contain a cover
              ),
            ),
          ),
          child, // Página de contenido
        ],
      ),
    );
  }
}
