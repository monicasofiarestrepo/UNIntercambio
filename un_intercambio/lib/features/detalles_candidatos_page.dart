import 'package:flutter/material.dart';
import 'package:un_intercambio/data/models/candidato.dart';
import 'package:un_intercambio/features/base_page.dart';

class DetallesCandidatoPage extends StatelessWidget {
  final Candidato candidato;

  const DetallesCandidatoPage({super.key, required this.candidato});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Detalles del Candidato",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _detalleItem(
                      icon: Icons.person,
                      label: "Nombre",
                      value: candidato.nombre,
                    ),
                    const SizedBox(height: 15),
                    _detalleItem(
                      icon: Icons.school,
                      label: "Programa",
                      value: candidato.programa,
                    ),
                    const SizedBox(height: 15),
                    _detalleItem(
                      icon: Icons.email,
                      label: "Correo",
                      value: candidato.correo,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detalleItem({required IconData icon, required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Color(0xFF58C2D1)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
