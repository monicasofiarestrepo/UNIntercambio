import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route; // Nueva propiedad para la ruta

  const OptionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route, // Ruta requerida
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route); // Navegar a la ruta proporcionada
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Icon(icon, color: Colors.grey),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: const TextButton(
            onPressed: null,
            child: Text('Ir', style: TextStyle(color: Colors.pink)),
          ),
        ),
      ),
    );
  }
}
