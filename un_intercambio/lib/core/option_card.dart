import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const OptionCard({Key? key,  required this.title, required this.subtitle, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
