import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:un_intercambio/core/buttons.dart';
import 'package:un_intercambio/data/models/usuario.dart';
import 'package:un_intercambio/features/base_page.dart';
import 'package:un_intercambio/data/providers/usuario_provider.dart';
import 'package:un_intercambio/core/global_variables.dart';
import 'package:un_intercambio/features/widgets/postulaciones.dart';

// ignore: must_be_immutable
class UserProfilePage extends ConsumerStatefulWidget {
  final String title;
  bool userInfo;

 UserProfilePage({super.key, required this.title, this.userInfo = true});

  @override
  ConsumerState<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
  List<PlatformFile> _archivos = [];

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
    final usuarioAsyncValue = ref.watch(usuarioActualProvider);
    final bool isEstudiante = getIsEstudiante(ref); // Get user type dynamically

    return BasePage(
      currentIndex: 3,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            usuarioAsyncValue.when(
              data: (usuario) {
                if (usuario == null) return const Text("Usuario no encontrado");
                return Text(
                  usuario.nombre,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const Text("Error al cargar usuario"),
            ),
            const SizedBox(height: 30),
            widget.userInfo
                ? buildUserInfoContainer(usuarioAsyncValue, isEstudiante)
                : PostulationsList(
                    postulations: [
                      Postulation(
                        title: "Convocatoria 1",
                        description: "Convocatoria para movilidad saliente internacional",
                        location: "EEUU",
                        status: "Activa",
                        progress: 0.8,
                      ),
                      Postulation(
                        title: "Convocatoria 2",
                        description: "Convocatoria para movilidad saliente internacional",
                        location: "España",
                        status: "Activa",
                        progress: 0.5,
                      ),
                      Postulation(
                        title: "Convocatoria 3",
                        description: "Convocatoria para movilidad saliente internacional",
                        location: "Alemania",
                        status: "Vencida",
                        progress: 0.3,
                      ),
                        Postulation(
                        title: "Convocatoria 4",
                        description: "Convocatoria para investigación",
                        location: "Alemania",
                        status: "Activa",
                        progress: 0.3,
                      ),
                      Postulation(
                        title: "Convocatoria 5",
                        description: "Convocatoria para doble titulación",
                        location: "Alemania",
                        status: "Activa",
                        progress: 0.3,
                      ),
                        Postulation(
                        title: "Convocatoria 6",
                        description: "Convocatoria para perrearse a extranjeros",
                        location: "España",
                        status: "Activa",
                        progress: 0.3,
                      ),
                    ],
                  ),


            isEstudiante?  SizedBox(width: 300, child: PrimaryButton(
              child: widget.userInfo
                  ? const Text("Ver estado de postulaciones")
                  : const Text("Ver información del usuario"),
              onPressed: () {
                setState(() {
                  widget.userInfo = !widget.userInfo;
                });
              },
            ),) : const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget buildUserInfoContainer(AsyncValue<Usuario?> usuarioAsyncValue, bool isEstudiante) {
    return Container(
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
              Center(
                child: Image.asset(
                  isEstudiante?  'assets/images/avatar2.png' : 'assets/images/avatar3.png',
                  fit: BoxFit.cover,
                ),
              ),
              InfoText(label: "Correo", value: usuario.correo),
              const InfoText(label: "Idiomas", value: "Inglés B1 y portugués A2"),
              const InfoText(label: "Celular", value: "3044833098"),
              InfoText(label: "Tipo de Usuario", value: isEstudiante ? "Estudiante" : "Administrador"),
              if (isEstudiante) ...[
                const InfoText(label: "Promedio", value: "4.8"),
                const InfoText(label: "Avance", value: "81%"),
                const InfoText(label: "Carrera", value: "Ing. Administrativa"),
              ],
              Center(
                child: GestureDetector(
                  onTap: _seleccionarArchivos,
                  child: isEstudiante?  Container(
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
                  ) : const SizedBox(),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text("Error al cargar usuario")),
      ),
    );
  }
}

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
