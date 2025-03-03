// ignore_for_file: use_build_context_synchronously

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:un_intercambio/core/theme.dart';
import 'package:un_intercambio/core/unintercambio_custom_icons.dart';
import 'package:un_intercambio/features/base_page.dart';

class PostulacionForm extends StatefulWidget {
  final String tituloConvocatoria;
  final String nivelIdioma;

  const PostulacionForm({
    super.key,
    required this.tituloConvocatoria,
    required this.nivelIdioma,
  });

  @override
  State<PostulacionForm> createState() => _PostulacionFormState();
}

class _PostulacionFormState extends State<PostulacionForm> {
  final Map<String, List<PlatformFile>> _archivos = {
    'Carta Motivación': [],
    'Hoja de vida': [],
    'Certificado Idiomas': [],
  };

  Future<void> _seleccionarArchivos(String tipo) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        _archivos[tipo] = result.files;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: 1,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              
              /// 🏫 Título de la Convocatoria
              Text(
                widget.tituloConvocatoria,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 8),
              
              /// 📍 Lugar de la Convocatoria
              Text(
                widget.nivelIdioma,
                style: const TextStyle(fontSize: 18, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 20),
              const Text(
                'Registre la información solicitada para presentarse a la convocatoria',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              
              const SizedBox(height: 20),
              
              /// 📋 Campos del formulario
              for (var label in ['Promedio', 'Porcentaje de avance', 'Carrera', 'Idiomas', 'Celular', 'Correo electrónico'])
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: label,
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              
              const SizedBox(height: 20),
              
              /// 📎 Subida de archivos
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _archivos.keys.map((tipo) {
                  return GestureDetector(
                    onTap: () => _seleccionarArchivos(tipo),
                    child: Column(
                      children: [
                        _archivos[tipo]!.isEmpty
                            ? const Column(
                                children: [
                                  Icon(Icons.upload_file, size: 40),
                                  SizedBox(height: 5),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.check_circle, color: Colors.green, size: 40),
                                  Text(
                                    'Seleccionados: ${_archivos[tipo]!.length}',
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                        Text(
                          tipo,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 30),
              
              /// 📤 Botón de postulación
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          title: const Text('¡Mucha suerte!', textAlign: TextAlign.center),
                          content: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(UNintercambioIcons.graduation_cap, color: SystemColors.primaryGreenDark, size: 60),
                              SizedBox(height: 10),
                              Text('Tu postulación ha sido enviada correctamente.'),
                            ],
                          ),
                        );
                      },
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacementNamed(context, '/home');
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SystemColors.primaryBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'Postularme',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
