import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:un_intercambio/features/base_page.dart';
import 'package:un_intercambio/data/providers/usuario_provider.dart';
import 'package:un_intercambio/data/models/usuario.dart';

class AdminProfilePage extends ConsumerStatefulWidget {
  final String title;

  const AdminProfilePage({super.key, required this.title});

  @override
  ConsumerState<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends ConsumerState<AdminProfilePage> {
  @override
  Widget build(BuildContext context) {
    final usuarioAsyncValue = ref.watch(usuarioActualProvider);

    return BasePage(
      currentIndex: 3,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            usuarioAsyncValue.when(
              data: (usuario) {
                if (usuario == null) return const Text("Administrador no encontrado");
                return Text(
                  usuario.nombre,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const Text("Error al cargar administrador"),
            ),
            const SizedBox(height: 30),
            Container(
              width: 380,
              height: 500,
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
                          'assets/images/avatar1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      InfoText(label: "Correo", value: usuario.correo),
                      InfoText(label: "Tipo de Usuario", value: usuario.tipoUsuario),
                      const InfoText(label: "Rol", value: "Administrador General"),
                      const InfoText(label: "Departamento", value: "Oficina de Relaciones Internacionales"),
                      const InfoText(label: "Extensión", value: "1234"),
                      const InfoText(label: "Teléfono", value: "601-5555555"),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const Center(child: Text("Error al cargar administrador")),
              ),
            ),
          ],
        ),
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
