import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:un_intercambio/core/theme.dart';
import 'package:un_intercambio/data/models/convocatoria.dart';
import 'package:un_intercambio/data/repositories/convocatoria_repository.dart';
import 'package:un_intercambio/features/base_page.dart';
import 'package:un_intercambio/features/candidatos_page.dart';

final convocatoriaProvider = FutureProvider<List<Convocatoria>>((ref) async {
  final repository = ConvocatoriaRepository();
  return repository.fetchConvocatorias();
});

class ConvocatoriaPage extends ConsumerStatefulWidget {
  final String title;

  const ConvocatoriaPage({super.key, required this.title});

  @override
  _ConvocatoriaPageState createState() => _ConvocatoriaPageState();
}

class _ConvocatoriaPageState extends ConsumerState<ConvocatoriaPage> {
  List<Convocatoria> convocatoriasFiltradas = [];
  String searchText = '';

  void filtrarConvocatorias(String query, List<Convocatoria> convocatorias) {
    setState(() {
      searchText = query;
      if (query.isEmpty) {
        convocatoriasFiltradas = List.from(convocatorias);
      } else {
        convocatoriasFiltradas = convocatorias.where((convocatoria) =>
          convocatoria.nombre.toLowerCase().contains(query.toLowerCase()) ||
          convocatoria.tipo.toLowerCase().contains(query.toLowerCase()) ||
          convocatoria.estado.toLowerCase().contains(query.toLowerCase())
        ).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final convocatoriaAsync = ref.watch(convocatoriaProvider);

    return BasePage(
      currentIndex: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: convocatoriaAsync.when(
          data: (convocatorias) {
            if (searchText.isEmpty && convocatoriasFiltradas.isEmpty) {
              convocatoriasFiltradas = List.from(convocatorias);
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                const Center(
                  child: Text(
                    'Convocatorias',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar convocatorias...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: SystemColors.neutralMedium),
                    ),
                  ),
                  onChanged: (value) => filtrarConvocatorias(value, convocatorias),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: convocatoriasFiltradas.length,
                    itemBuilder: (context, index) {
                      final convocatoria = convocatoriasFiltradas[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            convocatoria.nombre,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Tipo: ${convocatoria.tipo}"),
                              Text("Estado: ${convocatoria.estado}"),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CandidatosPage(convocatoria: convocatoria),
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
          error: (error, _) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
