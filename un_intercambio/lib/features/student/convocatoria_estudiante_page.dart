import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:un_intercambio/core/theme.dart';
import 'package:un_intercambio/features/base_page.dart';
import 'package:un_intercambio/features/student/detalle_convocatoria_page.dart';
import 'package:un_intercambio/data/models/convocatoria.dart';
import 'package:un_intercambio/data/providers/convocatoria_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String getCurrentTime() {
  return DateFormat('HH:mm').format(DateTime.now());
}

class ConvocatoriaEstudiantePage extends ConsumerStatefulWidget {
  const ConvocatoriaEstudiantePage({super.key});

  @override
  ConvocatoriaEstudiantePageState createState() =>
      ConvocatoriaEstudiantePageState();
}

class ConvocatoriaEstudiantePageState
    extends ConsumerState<ConvocatoriaEstudiantePage> {
  List<Convocatoria> convocatoriasFiltradas = [];
  List<Convocatoria> convocatoriasGuardadas = [];
  String searchText = '';

  void filtrarConvocatorias(List<Convocatoria> convocatorias, String query) {
    setState(() {
      searchText = query;
      convocatoriasFiltradas = query.isEmpty
          ? convocatorias
          : convocatorias
              .where((convocatoria) =>
                  convocatoria.nombre
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  convocatoria.tipo
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  convocatoria.nivelIdioma
                      .toLowerCase()
                      .contains(query.toLowerCase()))
              .toList();
    });
  }

  void guardarConvocatoria(Convocatoria convocatoria) {
    setState(() {
      if (!convocatoriasGuardadas.contains(convocatoria)) {
        convocatoriasGuardadas.add(convocatoria);
      }
    });
  }

  void postularConvocatoria(Convocatoria convocatoria) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetalleConvocatoriaPage(convocatoria: convocatoria),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final convocatoriasAsync = ref.watch(convocatoriaProvider);

    return BasePage(
      currentIndex: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getCurrentTime(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(Icons.signal_cellular_alt, size: 25),
                      SizedBox(width: 6),
                      Icon(Icons.wifi, size: 25),
                      SizedBox(width: 6),
                      Icon(Icons.battery_full, size: 25),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
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
                  borderSide:
                      const BorderSide(color: SystemColors.neutralMedium),
                ),
              ),
              onChanged: (query) {
                convocatoriasAsync.whenData((convocatorias) {
                  filtrarConvocatorias(convocatorias, query);
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: convocatoriasAsync.when(
                data: (convocatorias) {
                  if (convocatorias.isEmpty) {
                    return const Center(
                        child: Text("No hay convocatorias disponibles."));
                  }

                  // Si no hay búsqueda activa, mostrar todas las convocatorias
                  final listaMostrar = searchText.isEmpty
                      ? convocatorias
                      : convocatoriasFiltradas;

                  return ListView.builder(
                    itemCount: listaMostrar.length,
                    itemBuilder: (context, index) {
                      final convocatoria = listaMostrar[index];
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
                              Text(
                                  "Nivel de Idioma: ${convocatoria.nivelIdioma}"),
                              Text("Estado: ${convocatoria.estado}"),
                            ],
                          ),
                          trailing: Column(
                            children: [
                              TextButton(
                                onPressed: () =>
                                    guardarConvocatoria(convocatoria),
                                child: const Text(
                                  'Guardar',
                                  style: TextStyle(
                                    color: SystemColors.primaryViolet,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    postularConvocatoria(convocatoria),
                                child: const Text(
                                  'Postular',
                                  style: TextStyle(
                                    color: SystemColors.primaryBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
