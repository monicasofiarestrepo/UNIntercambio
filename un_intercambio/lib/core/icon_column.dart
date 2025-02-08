import 'package:flutter/material.dart';

class IconColumn extends StatelessWidget {
  final IconData icon;
  final String label;

  const IconColumn({Key? key, required this.icon, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 48, color: Colors.pink),
        const SizedBox(height: 8),
        Text(label, textAlign: TextAlign.center),
      ],
    );
  }
}
