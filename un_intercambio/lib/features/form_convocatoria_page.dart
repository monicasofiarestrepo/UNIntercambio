import 'package:flutter/material.dart';
import 'package:un_intercambio/features/widgets/bottom_nav_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:un_intercambio/core/theme.dart';
import 'package:un_intercambio/core/buttons.dart';
import 'package:un_intercambio/core/textfields.dart';
import 'package:un_intercambio/features/base_page.dart';
import 'package:intl/intl.dart';
import 'package:un_intercambio/data/repositories/convocatoria_repository.dart';

class FormularioConvocatoriaPage extends StatefulWidget {
  const FormularioConvocatoriaPage({super.key});

  @override
  State<FormularioConvocatoriaPage> createState() => _FormularioConvocatoriaPageState();
}

class _FormularioConvocatoriaPageState extends State<FormularioConvocatoriaPage> {
  final _formKey = GlobalKey<FormState>();
  final ConvocatoriaRepository _convocatoriaRepository = ConvocatoriaRepository();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _requisitosController = TextEditingController();
  final TextEditingController _promedioMinimoController = TextEditingController();
  final TextEditingController _nivelIdiomaController = TextEditingController();
  final TextEditingController _beneficiosController = TextEditingController();
  final TextEditingController _fechaInicioController = TextEditingController();
  final TextEditingController _fechaFinController = TextEditingController();

  String? _tipoConvocatoria = 'Saliente';
  List<PlatformFile> _archivos = [];

  Future<void> _seleccionarArchivos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        _archivos = result.files;
      });
    }
  }

  Future<void> _enviarFormulario() async {
    final convocatoria = {
      "idConvocatoria": "C001",
      "nombre": _nombreController.text,
      "tipo": _tipoConvocatoria,
      "descripcion": _descripcionController.text,
      "requisitos": _requisitosController.text,
      "promedioMinimo": double.tryParse(_promedioMinimoController.text) ?? 0.0,
      "nivelIdioma": _nivelIdiomaController.text,
      "beneficios": _beneficiosController.text,
      "fechaInicio": DateFormat('yyyy-MM-dd').parse(_fechaInicioController.text).toIso8601String(),
      "fechaFin": DateFormat('yyyy-MM-dd').parse(_fechaFinController.text).toIso8601String(),
      "estado": "Activa",
    };

    try {
      await _convocatoriaRepository.crearConvocatoria(convocatoria);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Convocatoria registrada exitosamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar: $e')),
      );
    }
  }

  Future<void> _seleccionarFecha(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: null,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 150),
              Text('Registro de convocatoria', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _tipoConvocatoria,
                decoration: const InputDecoration(
                  labelText: 'Tipo de Convocatoria',
                  border: OutlineInputBorder(),
                ),
                items: ['Saliente', 'Entrante', 'Internacional', 'Nacional'].map((tipo) {
                  return DropdownMenuItem(value: tipo, child: Text(tipo));
                }).toList(),
                onChanged: (value) => setState(() => _tipoConvocatoria = value),
              ),
              const SizedBox(height: 20),
              IconTextField(controller: _nombreController, label: 'Nombre', prefixIcon: const Icon(Icons.title)),
              const SizedBox(height: 20),
              IconTextField(controller: _descripcionController, label: 'Descripción'),
              const SizedBox(height: 20),
              IconTextField(controller: _requisitosController, label: 'Requisitos'),
              const SizedBox(height: 20),
              IconTextField(controller: _promedioMinimoController, label: 'Promedio mínimo', textInputType: TextInputType.number),
              const SizedBox(height: 20),
              IconTextField(controller: _nivelIdiomaController, label: 'Nivel de Idioma'),
              const SizedBox(height: 20),
              IconTextField(controller: _beneficiosController, label: 'Beneficios'),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => _seleccionarFecha(_fechaInicioController),
                child: AbsorbPointer(
                  child: IconTextField(controller: _fechaInicioController, label: 'Fecha de Inicio', prefixIcon: const Icon(Icons.calendar_today), readOnly: true),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => _seleccionarFecha(_fechaFinController),
                child: AbsorbPointer(
                  child: IconTextField(controller: _fechaFinController, label: 'Fecha de Fin', prefixIcon: const Icon(Icons.calendar_today), readOnly: true),
                ),
              ),
              const SizedBox(height: 20),
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
                          children: [Icon(Icons.upload_file, size: 40), Text('Selecciona archivos')],
                        )
                      : Text('${_archivos.length} archivo(s) seleccionado(s)'),
                ),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                onPressed: _enviarFormulario,
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
