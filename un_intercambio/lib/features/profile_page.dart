import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:un_intercambio/features/base_page.dart';

class UserProfilePage extends StatefulWidget {
  final String title;

  const UserProfilePage({super.key, required this.title});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  List<PlatformFile> _archivos = [];

  Future<void> _seleccionarArchivos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true, // Permite seleccionar múltiples archivos
    );

    if (result != null) {
      setState(() {
        _archivos = result.files; // Guardamos los archivos seleccionados
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      currentIndex: 3,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Text(
              "Estudiante 1",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Container(
              width: 380,
              height: 550,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade100,
              ),
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/avatar2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const InfoText(label: "Promedio", value: "4.8"),
                  const InfoText(label: "Avance", value: "81%"),
                  const InfoText(label: "Carrera", value: "Ing. Administrativa"),
                  const InfoText(label: "Idiomas", value: "Inglés B1 y portugués A2"),
                  const InfoText(label: "Correo", value: "estudiantosa@unal.edu.co"),
                  const InfoText(label: "Celular", value: "3044833098"),

                  // Botón de carga de archivos
                    Center(child:                  
                    GestureDetector(
                    onTap: _seleccionarArchivos,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                       
                        borderRadius: BorderRadius.circular(8),
                     
                      ),
                      child: _archivos.isEmpty
                          ? const Column(
                              children:  [
                                Icon(Icons.upload_file, size: 40),
                                Text('Hoja de vida', style: TextStyle(fontSize: 16)),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.check_circle, color: Colors.green, size: 40),
                                Text(
                                  'Archivos seleccionados: ${_archivos.length}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                    ),
                  ),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget reutilizable para mostrar texto con negritas
class InfoText extends StatelessWidget {
  final String label;
  final String value;

  const InfoText({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black),
          children: [
            TextSpan(
              text: "$label: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
