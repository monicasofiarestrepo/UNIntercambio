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

class ConvocatoriaConfPage extends ConsumerStatefulWidget {
  final String title;

  const ConvocatoriaConfPage({super.key, required this.title});

  @override
  _ConvocatoriaConfPageState createState() => _ConvocatoriaConfPageState();
}

class _ConvocatoriaConfPageState extends ConsumerState<ConvocatoriaConfPage> {
  List<Convocatoria> convocatoriasFiltradas = [];
  String searchText = '';

  void filtrarConvocatorias(String query, List<Convocatoria> convocatorias) {
    setState(() {
      searchText = query;
      if (query.isEmpty) {
        convocatoriasFiltradas = List.from(convocatorias);
      } else {
        convocatoriasFiltradas = convocatorias
            .where((convocatoria) =>
                convocatoria.nombre.toLowerCase().contains(query.toLowerCase()) ||
                convocatoria.tipo.toLowerCase().contains(query.toLowerCase()) ||
                convocatoria.estado.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void editarConvocatoria(Convocatoria convocatoria) {
    final TextEditingController nombreController = TextEditingController(text: convocatoria.nombre);
    final TextEditingController tipoController = TextEditingController(text: convocatoria.tipo);
    final TextEditingController estadoController = TextEditingController(text: convocatoria.estado);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Convocatoria'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                    controller: nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre')),
                TextField(
                    controller: tipoController,
                    decoration: const InputDecoration(labelText: 'Tipo de Movilidad')),
                TextField(
                    controller: estadoController,
                    decoration: const InputDecoration(labelText: 'Estado')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Actualización pendiente con el repositorio.
                setState(() {});
                Navigator.pop(context);
              },
              child: const Text(
                'Guardar',
                style: TextStyle(
                  color: SystemColors.primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void eliminarConvocatoria(Convocatoria convocatoria) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: const Text('¿Estás seguro de que deseas eliminar esta convocatoria?'),
          actions: [
            TextButton(
              onPressed: () async {
                // Eliminación pendiente con el repositorio.
                setState(() {});
                Navigator.pop(context);
              },
              child: const Text(
                'Eliminar',
                style: TextStyle(
                  color: SystemColors.labelError,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
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
                                builder: (context) =>
                                    CandidatosPage(convocatoria: convocatoria),
                              ),
                            );
                          },
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: SystemColors.primaryBlue),
                                onPressed: () => editarConvocatoria(convocatoria),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: SystemColors.labelError),
                                onPressed: () => eliminarConvocatoria(convocatoria),
                              ),
                            ],
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
          error: (error, _) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
