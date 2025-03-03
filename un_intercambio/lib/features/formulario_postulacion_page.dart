// ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:un_intercambio/core/theme.dart';
import 'package:un_intercambio/core/unintercambio_custom_icons.dart';
import 'package:un_intercambio/features/base_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:un_intercambio/data/providers/postulacion_provider.dart';
import 'package:un_intercambio/data/models/postulacion.dart';
import 'package:un_intercambio/data/providers/usuario_provider.dart'; // 🔹 Usar el provider de usuario

class PostulacionForm extends ConsumerStatefulWidget {
  final String tituloConvocatoria;
  final String descripcionConvocatoria;
  final String nivelIdioma;
  final String idConvocatoria;


  const PostulacionForm({
    super.key,
    required this.tituloConvocatoria,
    required this.descripcionConvocatoria,
    required this.nivelIdioma,
    required this.idConvocatoria,
  });

  @override
  ConsumerState<PostulacionForm> createState() => _PostulacionFormState();
}

class _PostulacionFormState extends ConsumerState<PostulacionForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _promedioController = TextEditingController();
  final TextEditingController _porcentajeAvanceController = TextEditingController();
  final TextEditingController _carreraController = TextEditingController();
  final TextEditingController _idiomasController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final usuarioAsyncValue = ref.read(usuarioActualProvider);
      usuarioAsyncValue.whenData((usuario) {
        if (usuario != null) {
          _correoController.text = usuario.correo;
          
        }
      });
    });
  }

  void _postular() async {
    final postulacion = Postulacion(
      nombreConvocatoria: widget.tituloConvocatoria,
      descripcion: widget.descripcionConvocatoria,
      correoElectronico: _correoController.text.trim(),
      idConvocatoria: widget.idConvocatoria,
      estado: "pendiente",
      promedio: double.tryParse(_promedioController.text.trim()) ?? 0.0,
      porcentajeAvance: int.tryParse(_porcentajeAvanceController.text.trim()) ?? 0,
      carrera: _carreraController.text.trim(),
      idiomas: _idiomasController.text.trim(),
      celular: _celularController.text.trim(),
    );

    final resultado = await ref.read(postularFutureProvider(postulacion).future);

    if (resultado) {
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
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.of(context).pop();
        Navigator.pushReplacementNamed(context, '/home');
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al enviar la postulación.')), 
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return BasePage(
          currentIndex: 1,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Text(widget.tituloConvocatoria, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    Text(widget.nivelIdioma, style: const TextStyle(fontSize: 18, color: Colors.black54), textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    const Text('Registre la información solicitada para presentarse a la convocatoria', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.black54)),
                    const SizedBox(height: 20),

                    _buildTextField(_promedioController, 'Promedio'),
                    _buildTextField(_porcentajeAvanceController, 'Porcentaje de avance'),
                    _buildTextField(_carreraController, 'Carrera'),
                    _buildTextField(_idiomasController, 'Idiomas'),
                    _buildTextField(_celularController, 'Celular'),
                    _buildTextField(_correoController, 'Correo electrónico', enabled: false),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _postular,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: SystemColors.primaryBlue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Postularme', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: enabled ? Colors.grey[200] : Colors.grey[300],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
