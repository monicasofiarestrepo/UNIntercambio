import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const OptionCard({Key? key, required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.arrow_forward, color: Colors.pink),
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
