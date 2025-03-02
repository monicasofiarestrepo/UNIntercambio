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
          title: Text('Editar Convocatoria'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nombreController, decoration: InputDecoration(labelText: 'Nombre')),
                TextField(controller: tipoController, decoration: InputDecoration(labelText: 'Tipo de Movilidad')),
                TextField(controller: estadoController, decoration: InputDecoration(labelText: 'Estado')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final updatedConvocatoria = Convocatoria(
                  id: convocatoria.id,
                  idConvocatoria: convocatoria.idConvocatoria,
                  nombre: nombreController.text,
                  tipo: tipoController.text,
                  descripcion: convocatoria.descripcion,
                  requisitos: convocatoria.requisitos,
                  promedioMinimo: convocatoria.promedioMinimo,
                  nivelIdioma: convocatoria.nivelIdioma,
                  beneficios: convocatoria.beneficios,
                  fechaInicio: convocatoria.fechaInicio,
                  fechaFin: convocatoria.fechaFin,
                  estado: estadoController.text,
                );

                // TODO: Llamar al método del repositorio para actualizar la convocatoria si tienes uno
                // await repository.updateConvocatoria(updatedConvocatoria);

                setState(() {});
                Navigator.pop(context);
              },
              child: Text('Guardar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
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
          title: Text('Confirmar eliminación'),
          content: Text('¿Estás seguro de que deseas eliminar esta convocatoria?'),
          actions: [
            TextButton(
              onPressed: () async {
                // TODO: Llamar al método del repositorio para eliminar la convocatoria si tienes uno
                // await repository.deleteConvocatoria(convocatoria.id);

                setState(() {});
                Navigator.pop(context);
              },
              child: Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
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
                const SizedBox(height: 150),
                Text(
                  'Convocatorias',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  'Gestiona las convocatorias de movilidad fácilmente.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar convocatorias...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: SystemColors.neutralMedium),
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
                        color: SystemColors.neutralBackground1,
                        child: ListTile(
                          title: Text(convocatoria.nombre),
                          subtitle: Text(
                            "Tipo: ${convocatoria.tipo} | Estado: ${convocatoria.estado}",
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CandidatosPage(convocatoria: convocatoria),
                              ),
                            );
                          },
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: SystemColors.primaryBlue),
                                onPressed: () => editarConvocatoria(convocatoria),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: SystemColors.labelError),
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
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
