import 'package:flutter/material.dart';
import 'package:un_intercambio/features/widgets/bottom_nav_bar.dart';
import 'package:file_picker/file_picker.dart'; // Para la funcionalidad de selección de archivos
import 'package:un_intercambio/core/theme.dart';  
import 'package:un_intercambio/core/buttons.dart';  
import 'package:un_intercambio/core/textfields.dart';  
import 'package:un_intercambio/features/base_page.dart';
import 'package:intl/intl.dart'; // Para el formato de fecha

//TODO arreglar el scroll
//TODO hacerlo funcional
//TODO la fecha creo que no está funcionando
//TODO hacer más bonitos los campos
//TODO hacer que cuando se abran las nuevas paginas se deseleccione el home
//TODO revisar si se pueden utilizar widgets o colores ya creados


class FormularioConvocatoriaPage extends StatefulWidget {
  const FormularioConvocatoriaPage({super.key}); 

  @override
  State<FormularioConvocatoriaPage> createState() => _FormularioConvocatoriaPageState();
}

class _FormularioConvocatoriaPageState extends State<FormularioConvocatoriaPage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _requisitosController = TextEditingController();
  final TextEditingController _duracionController = TextEditingController();
  final TextEditingController _lugarController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();

  String? _tipoConvocatoria = 'Saliente';  // Variable para el dropdown
  List<PlatformFile> _archivos = [];  // Para almacenar los archivos seleccionados

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: 0, // Ajusta el índice según la página que estés mostrando
      child: SingleChildScrollView(  // Aquí envuelves todo en un SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 150),
              // Título y subtítulo
              Text(
                'Formulario de registro de nueva convocatoria',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Registre la información relevante de la convocatoria',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),

              // Aquí solo envuelves el DropdownButtonFormField en el SingleChildScrollView
              SingleChildScrollView(  
                child: DropdownButtonFormField<String>(
                  value: _tipoConvocatoria,
                  decoration: const InputDecoration(
                    labelText: 'Tipo de Convocatoria',
                    prefixIcon: Icon(Icons.event),
                    border: OutlineInputBorder(),
                  ),
                  items: ['Saliente', 'Entrante', 'Internacional', 'Nacional']
                      .map((String tipo) {
                    return DropdownMenuItem<String>(
                      value: tipo,
                      child: Text(tipo),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _tipoConvocatoria = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Campo para Título
              IconTextField(
                controller: _tituloController,
                label: 'Título',
                prefixIcon: const Icon(Icons.title),
                suffixIcon: const Icon(Icons.clear),
              ),
              const SizedBox(height: 20),

              // Campo para Descripción Breve
              IconTextField(
                controller: _descripcionController,
                label: 'Descripción breve',
                prefixIcon: const Icon(Icons.description),
                suffixIcon: const Icon(Icons.clear),
              ),
              const SizedBox(height: 20),

              // Campo para Requisitos
              IconTextField(
                controller: _requisitosController,
                label: 'Requisitos',
                prefixIcon: const Icon(Icons.list),
                suffixIcon: const Icon(Icons.clear),
              ),
              const SizedBox(height: 20),

              // Campo para Duración
              IconTextField(
                controller: _duracionController,
                label: 'Duración',
                prefixIcon: const Icon(Icons.access_time),
                suffixIcon: const Icon(Icons.clear),
              ),
              const SizedBox(height: 20),

              // Campo para Lugar
              IconTextField(
                controller: _lugarController,
                label: 'Lugar',
                prefixIcon: const Icon(Icons.location_on),
                suffixIcon: const Icon(Icons.clear),
              ),
              const SizedBox(height: 20),

              // Campo para Fecha
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _fechaController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                    });
                  }
                },
                child: TextField(
                  controller: _fechaController,
                  decoration: const InputDecoration(
                    labelText: 'Fecha',
                    prefixIcon: Icon(Icons.calendar_today),
                    suffixIcon: Icon(Icons.clear),
                  ),
                  readOnly: true, // Esto evita que el usuario edite el campo manualmente
                ),
              ),
              const SizedBox(height: 20),

              // Caja para arrastrar o seleccionar archivos
              GestureDetector(
                onTap: _seleccionarArchivos,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: _archivos.isEmpty
                      ? const Column(
                          children: [
                            Icon(Icons.upload_file, size: 40),
                            Text('Arrastra o selecciona archivos', style: TextStyle(fontSize: 16)),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green, size: 40),
                            Text('Archivos seleccionados: ${_archivos.length}', style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 20),

              // Botón para registrar
              PrimaryButton(
                onPressed: () {
                  // Acción al presionar el botón
                  print('Formulario enviado');
                  // Aquí puedes agregar la lógica para procesar los datos
                },
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para seleccionar archivos
  Future<void> _seleccionarArchivos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        _archivos = result.files;
      });
    }
  }
}
