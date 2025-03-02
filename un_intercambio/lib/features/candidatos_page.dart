import 'package:flutter/material.dart';
import 'package:un_intercambio/core/theme.dart';
import 'package:un_intercambio/features/detalles_candidatos_page.dart';
import 'package:un_intercambio/features/convocatoria_page.dart';

class Candidato {
  final String nombre;
  final String programa;
  final String semestre;
  final String correo;

  Candidato({
    required this.nombre,
    required this.programa,
    required this.semestre,
    required this.correo,
  });
}

class CandidatosPage extends StatelessWidget {
  final Convocatoria convocatoria;
  final List<Candidato> candidatos = [
    Candidato(nombre: "Estudiante 1", programa: "Administración", semestre: "4", correo: "correo1@ejemplo.com"),
    Candidato(nombre: "Estudiante 2", programa: "Ingeniería Agrícola", semestre: "7", correo: "correo2@ejemplo.com"),
    Candidato(nombre: "Estudiante 3", programa: "Matemáticas", semestre: "5", correo: "correo3@ejemplo.com"),
  ];

  CandidatosPage({super.key, required this.convocatoria});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Candidatos postulados - ${convocatoria.nombre}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar candidato...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: SystemColors.neutralMedium),
                ),
              ),
              // Aquí podrías implementar la búsqueda de candidatos.
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: candidatos.length,
                itemBuilder: (context, index) {
                  final candidato = candidatos[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(candidato.nombre),
                      subtitle: Text("Programa: ${candidato.programa} | Semestre: ${candidato.semestre}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetallesCandidatoPage(candidato: candidato),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
