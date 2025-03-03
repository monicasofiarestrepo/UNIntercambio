import 'package:flutter/material.dart';
import 'package:un_intercambio/core/unintercambio_custom_icons.dart';
import 'package:un_intercambio/core/theme.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    const routes = ['/home', '/convocatorias', '/chat', '/profile'];

    if (currentIndex != index) {
      Navigator.pushReplacementNamed(context, routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: SystemColors.primaryBlue,
      unselectedItemColor: SystemColors.neutralMedium,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(UNintercambioIcons.home_1), label: 'Inicio'),
        BottomNavigationBarItem(
            icon: Icon(UNintercambioIcons.book_open), label: 'Convocatorias'),
        BottomNavigationBarItem(
            icon: Icon(UNintercambioIcons.chat_1), label: 'Chat'),
        BottomNavigationBarItem(
            icon: Icon(UNintercambioIcons.user), label: 'Perfil'),
      ],
    );
  }
}
