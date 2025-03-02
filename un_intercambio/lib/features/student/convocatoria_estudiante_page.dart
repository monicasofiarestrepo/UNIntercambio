import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:un_intercambio/core/theme.dart';
import 'package:un_intercambio/features/base_page.dart';
import 'package:un_intercambio/features/student/detalle_convocatoria_page.dart';
import 'package:un_intercambio/data/convocatorias_data.dart';
import 'package:un_intercambio/models/convocatoria_estudiante.dart';

String getCurrentTime() {
  return DateFormat('HH:mm').format(DateTime.now());
}

class ConvocatoriaEstudiantePage extends StatefulWidget {
  const ConvocatoriaEstudiantePage({super.key});

  @override
  ConvocatoriaEstudiantePageState createState() =>
      ConvocatoriaEstudiantePageState();
}

class ConvocatoriaEstudiantePageState
    extends State<ConvocatoriaEstudiantePage> {
  List<ConvocatoriaEstudiante> convocatoriasFiltradas = [];
  List<ConvocatoriaEstudiante> convocatoriasGuardadas = [];
  String searchText = '';

  @override
  void initState() {
    super.initState();
    convocatoriasFiltradas = List.from(convocatorias);
  }

  void filtrarConvocatorias(String query) {
    setState(() {
      searchText = query;
      convocatoriasFiltradas = query.isEmpty
          ? List.from(convocatorias)
          : convocatorias
              .where((convocatoria) =>
                  convocatoria.nombre
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  convocatoria.tipoMovilidad
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  convocatoria.tipo
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  convocatoria.lugar
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  convocatoria.idioma
                      .toLowerCase()
                      .contains(query.toLowerCase()))
              .toList();
    });
  }

  void guardarConvocatoria(ConvocatoriaEstudiante convocatoria) {
    setState(() {
      if (!convocatoriasGuardadas.contains(convocatoria)) {
        convocatoriasGuardadas.add(convocatoria);
      }
    });
  }

  void postularConvocatoria(ConvocatoriaEstudiante convocatoria) {
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
    return BasePage(
      currentIndex: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hora y estado de la red en la parte superior
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
            // Título centrado
            const Center(
              child:  Text(
                'Convocatorias',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Buscador
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar convocatorias...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: SystemColors.neutralMedium),
                ),
              ),
              onChanged: filtrarConvocatorias,
            ),
            const SizedBox(height: 16),
            // Lista de convocatorias
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
                          // Tipo de movilidad
                          Text(
                            "Movilidad ${convocatoria.tipoMovilidad}",
                          ),
                          // Tipo (Nacional o Internacional)
                          Text(
                            convocatoria.tipo,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey),
                          ),
                          // Lugar e Idioma en una fila
                          Row(
                            children: [
                              const Icon(Icons.place, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(convocatoria.lugar),
                              const SizedBox(width: 10),
                              const Icon(Icons.language,
                                  size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(convocatoria.idioma),
                            ],
                          ),
                        ],
                      ),
                      trailing: SizedBox(
                        width: 80, // Ajusta el ancho si es necesario
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Asegura que los botones no se expandan innecesariamente
                          children: [
                            Flexible(
                              child: TextButton(
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
                            ),
                            const SizedBox(height: 18),
                            Flexible(
                              child: TextButton(
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
                            ),
                          ],
                        ),
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
