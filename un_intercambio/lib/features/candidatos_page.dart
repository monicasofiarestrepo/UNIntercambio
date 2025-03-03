import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:un_intercambio/core/theme.dart';
import 'package:un_intercambio/data/models/candidato.dart';
import 'package:un_intercambio/data/repositories/candidato_repository.dart';
import 'package:un_intercambio/features/detalles_candidatos_page.dart';
import 'package:un_intercambio/features/base_page.dart';

final candidatosProvider = FutureProvider.family<List<Candidato>, String?>((ref, convocatoriaId) async {
  final repository = CandidatoRepository();
  return repository.fetchCandidatosPorConvocatoria(convocatoriaId!);
});

class CandidatosPage extends ConsumerStatefulWidget {
  final String? convocatoriaId;
  final String convocatoriaNombre;

  const CandidatosPage({
    super.key,
    required this.convocatoriaId,
    required this.convocatoriaNombre,
  });

  @override
  ConsumerState<CandidatosPage> createState() => _CandidatosPageState();
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
            candidato.programa.toLowerCase().contains(query.toLowerCase())
        ).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final candidatosAsync = ref.watch(candidatosProvider(widget.convocatoriaId));

    return BasePage(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: candidatosAsync.when(
          data: (candidatos) {
            if (searchText.isEmpty && candidatosFiltrados.isEmpty) {
              candidatosFiltrados = List.from(candidatos);
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  'Candidatos postulados',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.convocatoriaNombre,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: const Icon(Icons.filter_list),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: SystemColors.neutralMedium),
                    ),
                    filled: true,
                  ),
                  onChanged: (value) => filtrarCandidatos(value, candidatos),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: candidatosFiltrados.length,
                    itemBuilder: (context, index) {
                      final candidato = candidatosFiltrados[index];
                      final seleccionado = seleccionados.contains(candidato.id);

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: const CircleAvatar(
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
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            'Promedio: ${candidato.promedio}\n'
                            'Carrera: ${candidato.programa}',
                            style: const TextStyle(
                              height: 1.5,
                            ),
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
          error: (error, stack) => Center(
            child: Text(
              'Error: $error',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ),
      ),
    );
  }
}
