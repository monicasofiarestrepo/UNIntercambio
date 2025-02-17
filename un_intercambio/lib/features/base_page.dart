import 'package:flutter/material.dart';
import 'package:un_intercambio/features/widgets/bottom_nav_bar.dart';

//TODO Añadir un hipervinculo en el logo para que envíe siempre al home
//TODO añadir lo de la campanita y el menú?
//TODO arreglar que el fonde tiene un margen que no sé cómo quitar

class BasePage extends StatelessWidget {
  final int currentIndex;
  final Widget child;

  const BasePage({
    Key? key,
    required this.currentIndex,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: currentIndex),
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
          child, // Página de contenido
        ],
      ),
    );
  }
}
