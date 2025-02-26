import 'package:flutter/material.dart';
import 'package:un_intercambio/core/theme.dart';
import 'package:un_intercambio/features/base_page.dart';
import 'package:un_intercambio/features/candidatos_page.dart';

//TODO hacer más bonitos los campos
//TODO hacer que cuando se abran las nuevas paginas se deseleccione el home
//TODO arreglar el formulario que aparece para editar y hacerlo funcional
//TODO revisar si se pueden utilizar widgets o colores ya creados

class Convocatoria {
  String nombre;
  String tipoMovilidad;
  String estado;
  String lugar;

  Convocatoria({
    required this.nombre,
    required this.tipoMovilidad,
    required this.estado,
    required this.lugar,
  });
}

class ConvocatoriaPage extends StatefulWidget {
  final String title;

  const ConvocatoriaPage({super.key, required this.title});

  @override
  _ConvocatoriaPageState createState() => _ConvocatoriaPageState();
}

class _ConvocatoriaPageState extends State<ConvocatoriaPage> {
  final List<Convocatoria> convocatorias = [
    Convocatoria(nombre: "Intercambio a España 2024", tipoMovilidad: "Saliente", estado: "Activa", lugar: "España"),
    Convocatoria(nombre: "Programa de intercambio Alemania", tipoMovilidad: "Entrante", estado: "Cerrada", lugar: "Alemania"),
    Convocatoria(nombre: "Intercambio con Japón", tipoMovilidad: "Saliente", estado: "Activa", lugar: "Japón"),
  ];

  List<Convocatoria> convocatoriasFiltradas = [];
  String searchText = '';

  @override
  void initState() {
    super.initState();
    convocatoriasFiltradas = List.from(convocatorias);
  }

  void filtrarConvocatorias(String query) {
    setState(() {
      searchText = query;
      if (query.isEmpty) {
        convocatoriasFiltradas = List.from(convocatorias);
      } else {
        convocatoriasFiltradas = convocatorias
            .where((convocatoria) =>
                convocatoria.nombre.toLowerCase().contains(query.toLowerCase()) ||
                convocatoria.tipoMovilidad.toLowerCase().contains(query.toLowerCase()) ||
                convocatoria.estado.toLowerCase().contains(query.toLowerCase()) ||
                convocatoria.lugar.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void editarConvocatoria(Convocatoria convocatoria) {
    final TextEditingController nombreController = TextEditingController(text: convocatoria.nombre);
    final TextEditingController tipoMovilidadController = TextEditingController(text: convocatoria.tipoMovilidad);
    final TextEditingController estadoController = TextEditingController(text: convocatoria.estado);
    final TextEditingController lugarController = TextEditingController(text: convocatoria.lugar);

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
                TextField(controller: tipoMovilidadController, decoration: InputDecoration(labelText: 'Tipo de Movilidad')),
                TextField(controller: estadoController, decoration: InputDecoration(labelText: 'Estado')),
                TextField(controller: lugarController, decoration: InputDecoration(labelText: 'Lugar')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  convocatoria.nombre = nombreController.text;
                  convocatoria.tipoMovilidad = tipoMovilidadController.text;
                  convocatoria.estado = estadoController.text;
                  convocatoria.lugar = lugarController.text;
                });
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
              onPressed: () {
                setState(() {
                  convocatorias.remove(convocatoria);
                  convocatoriasFiltradas.remove(convocatoria);
                });
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
    return BasePage(
      currentIndex: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 150),
            Text(
              'Convocatorias',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Gestiona las convocatorias de movilidad fácilmente.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            // Barra de búsqueda
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar convocatorias...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: SystemColors.neutralMedium),
                ),
              ),
              onChanged: filtrarConvocatorias,
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
                        "Tipo: ${convocatoria.tipoMovilidad} | Estado: ${convocatoria.estado} | Lugar: ${convocatoria.lugar}",
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
        ),
      ),
    );
  }
}
