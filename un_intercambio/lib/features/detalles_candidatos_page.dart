import 'package:flutter/material.dart';
import 'package:un_intercambio/data/models/candidato.dart';

class DetallesCandidatoPage extends StatelessWidget {
  final Candidato candidato;

  const DetallesCandidatoPage({super.key, required this.candidato});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalles de ${candidato.nombre}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nombre: ${candidato.nombre}",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text("Programa: ${candidato.programa}"),
            Text("Correo: ${candidato.correo}"),
          ],
        ),
      ),
    );
  }
}
