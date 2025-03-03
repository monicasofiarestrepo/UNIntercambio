import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:un_intercambio/core/theme.dart';
import 'package:un_intercambio/features/base_page.dart';
import 'package:un_intercambio/data/models/convocatoria.dart';
import 'package:un_intercambio/features/chat_page.dart';
import 'package:un_intercambio/features/formulario_postulacion_page.dart';

String getCurrentTime() {
  return DateFormat('HH:mm').format(DateTime.now());
}

class DetalleConvocatoriaPage extends StatelessWidget {
  final Convocatoria convocatoria;

  const DetalleConvocatoriaPage({super.key, required this.convocatoria});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backgroundImageRoute: 'assets/images/backgroundWithLogo.png',
      currentIndex: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            const SizedBox(height: 10),
            // Flecha de regreso dentro de BasePage
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_back, size: 30, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 50),
            Text(
              convocatoria.nombre,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 400, // Ajusta la altura según lo necesites
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _detalleItem(Icons.category, "Tipo", convocatoria.tipo),
                        _detalleItem(Icons.language, "Nivel Idioma",
                            convocatoria.nivelIdioma),
                        _detalleItem(Icons.timeline, "Promedio",
                            convocatoria.promedioMinimo.toString()),
                        _detalleItem(Icons.date_range, "Fechas",
                            "${DateFormat('dd/MM/yyyy').format(convocatoria.fechaInicio)} - ${DateFormat('dd/MM/yyyy').format(convocatoria.fechaFin)}"),
                        _detalleItem(Icons.description, "Descripción",
                            convocatoria.descripcion,
                            multiline: true),
                        _detalleItem(Icons.assignment, "Requisitos",
                            convocatoria.requisitos,
                            multiline: true),
                        _detalleItem(Icons.card_giftcard, "Beneficios",
                            convocatoria.beneficios,
                            multiline: true),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10, // Espacio horizontal entre botones
              runSpacing: 8, // Espacio vertical si se acomodan en varias líneas
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatPage(title: "Representantes de la convocatoria"),
                      ),
                    );
                  },
                  child: const Text(
                    "Ir al Chat",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: SystemColors.primaryGreenDark),
                  ),
                ),
                TextButton(
                  onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  PostulacionForm(tituloConvocatoria: convocatoria.nombre , nivelIdioma: convocatoria.nivelIdioma, descripcionConvocatoria: convocatoria.descripcion, idConvocatoria: convocatoria.id!),
                    ));
                  },
                  child: const Text(
                    "Postularme",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: SystemColors.primaryBlue),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _detalleItem(IconData icon, String label, String value,
      {bool multiline = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment:
            multiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$label:",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(value, textAlign: TextAlign.justify),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

