import 'package:flutter/material.dart';
import 'package:un_intercambio/core/theme.dart';

class IconColumn extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route; // Nueva propiedad para la ruta

  const IconColumn({
    super.key,
    required this.icon,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route); // Navegar a la ruta proporcionada
      },
      child: Column(
        children: [
          Icon(icon, size: 40, color: SystemColors.primaryPrink),
          const SizedBox(height: 8),
          Text(label,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }
}
