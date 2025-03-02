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
  Set<int> seleccionados = {};

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
                    hintText: 'Buscar...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: const Icon(Icons.filter_list),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
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
                      final seleccionado = seleccionados.contains(candidato.id);

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: SystemColors.neutralLight,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              color: SystemColors.primaryBlue,
                            ),
                          ),
                          title: Text(
                            candidato.nombre,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Promedio: ${candidato.promedio}\n'
                            'Avance: ${candidato.avance}%\n'
                            'Carrera: ${candidato.programa}',
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              seleccionado ? Icons.check_box : Icons.check_box_outline_blank,
                              color: seleccionado ? SystemColors.primaryBlue : Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                if (seleccionado) {
                                  seleccionados.remove(candidato.id);
                                } else {
                                  seleccionados.add(candidato.id);
                                }
                              });
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetallesCandidatoPage(candidato: candidato),
                              ),
                            );
                          },
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
