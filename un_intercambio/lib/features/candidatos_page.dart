import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:un_intercambio/core/theme.dart';
import 'package:un_intercambio/data/models/candidato.dart';
import 'package:un_intercambio/data/repositories/candidato_repository.dart';
import 'package:un_intercambio/features/detalles_candidatos_page.dart';
import 'package:un_intercambio/data/models/convocatoria.dart';

final candidatosProvider = FutureProvider.family<List<Candidato>, int>((ref, convocatoriaId) async {
  final repository = CandidatoRepository();
  return repository.fetchCandidatosPorConvocatoria(convocatoriaId);
});

class CandidatosPage extends ConsumerStatefulWidget {
  final Convocatoria convocatoria;

  const CandidatosPage({super.key, required this.convocatoria});

  @override
  _CandidatosPageState createState() => _CandidatosPageState();
}

class _CandidatosPageState extends ConsumerState<CandidatosPage> {
  List<Candidato> candidatosFiltrados = [];
  String searchText = '';

  void filtrarCandidatos(String query, List<Candidato> candidatos) {
    setState(() {
      searchText = query;
      if (query.isEmpty) {
        candidatosFiltrados = List.from(candidatos);
      } else {
        candidatosFiltrados = candidatos.where((candidato) =>
          candidato.nombre.toLowerCase().contains(query.toLowerCase()) ||
          candidato.programa.toLowerCase().contains(query.toLowerCase()) ||
          candidato.semestre.toLowerCase().contains(query.toLowerCase())
        ).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final candidatosAsync = ref.watch(
      candidatosProvider(widget.convocatoria.idConvocatoria as int)
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Candidatos postulados - ${widget.convocatoria.nombre}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: candidatosAsync.when(
          data: (candidatos) {
            if (searchText.isEmpty && candidatosFiltrados.isEmpty) {
              candidatosFiltrados = List.from(candidatos);
            }

            return Column(
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
                  onChanged: (value) => filtrarCandidatos(value, candidatos),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: candidatosFiltrados.length,
                    itemBuilder: (context, index) {
                      final candidato = candidatosFiltrados[index];
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
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
