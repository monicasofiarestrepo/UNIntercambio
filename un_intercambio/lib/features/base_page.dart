import 'package:flutter/material.dart';
import 'package:un_intercambio/features/widgets/bottom_nav_bar.dart';

class BasePage extends StatelessWidget {
  final int? currentIndex;
  final Widget child;
  final bool showBottomNavBar;
  final String backgroundImageRoute;

  const BasePage({
    super.key,
    this.currentIndex,
    required this.child,
    this.showBottomNavBar = true, // Por defecto se muestra el BottomNavBar
    this.backgroundImageRoute = "assets/images/noLogoBackground.png",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: showBottomNavBar && currentIndex != null
          ? BottomNavBar(currentIndex: currentIndex!)
          : null, // No muestra el navbar si showBottomNavBar es false
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImageRoute),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          child, // Página de contenido
        ],
      ),
    );
  }
}
