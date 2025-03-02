import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:un_intercambio/features/base_page.dart';
import 'package:un_intercambio/data/providers/usuario_provider.dart';
import 'package:un_intercambio/data/models/usuario.dart';

// Página de perfil de usuario que usa Riverpod para obtener datos desde la API
class UserProfilePage extends ConsumerStatefulWidget {
  final String title;

  const UserProfilePage({super.key, required this.title});

  @override
  ConsumerState<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
  List<PlatformFile> _archivos = []; // Lista para almacenar archivos seleccionados

  // Método para seleccionar archivos usando FilePicker
  Future<void> _seleccionarArchivos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _archivos = result.files;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ahora se usa usuarioActualProvider en lugar de usuarioProvider
    final usuarioAsyncValue = ref.watch(usuarioActualProvider);

    return BasePage(
      currentIndex: 3, // Índice actual en la barra de navegación
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            // Mostrar nombre del usuario si los datos están disponibles
            usuarioAsyncValue.when(
              data: (usuario) {
                if (usuario == null) return const Text("Usuario no encontrado");
                return Text(
                  usuario.nombre,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                );
              },
              loading: () => const CircularProgressIndicator(), // Indicador de carga
              error: (_, __) => const Text("Error al cargar usuario"),
            ),
            const SizedBox(height: 30),
            // Contenedor con información del usuario
            Container(
              width: 380,
              height: 550,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade100,
              ),
              padding: const EdgeInsets.all(30),
              child: usuarioAsyncValue.when(
                data: (usuario) {
                  if (usuario == null) return const Center(child: Text("No hay datos"));

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Imagen de avatar
                      Center(
                        child: Image.asset(
                          'assets/images/avatar2.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Información del usuario
                      InfoText(label: "Correo", value: usuario.correo), // viene del endpoint de Riverpod
                      InfoText(label: "Tipo de Usuario", value: usuario.tipoUsuario), // viene del endpoint de Riverpod
                      const InfoText(label: "Promedio", value: "4.8"), // Estático porque el endpoint no lo trae 
                      const InfoText(label: "Avance", value: "81%"),
                      const InfoText(label: "Carrera", value: "Ing. Administrativa"),
                      const InfoText(label: "Idiomas", value: "Inglés B1 y portugués A2"),
                      const InfoText(label: "Celular", value: "3044833098"),

                      // Botón para subir archivos
                      Center(
                        child: GestureDetector(
                          onTap: _seleccionarArchivos,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: _archivos.isEmpty
                                ? const Column(
                                    children: [
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
                        ),
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()), // Indicador de carga
                error: (_, __) => const Center(child: Text("Error al cargar usuario")),
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
