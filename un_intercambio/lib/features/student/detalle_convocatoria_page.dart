import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:un_intercambio/core/theme.dart';
import 'package:un_intercambio/features/base_page.dart';
import 'package:un_intercambio/data/models/convocatoria.dart';

String getCurrentTime() {
  return DateFormat('HH:mm').format(DateTime.now());
}

class DetalleConvocatoriaPage extends StatelessWidget {
  final Convocatoria convocatoria;

  const DetalleConvocatoriaPage({super.key, required this.convocatoria});

  @override
  Widget build(BuildContext context) {
    return BasePage(
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
            const SizedBox(height: 30),
            Text(
              convocatoria.nombre,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //_detalleItem(
                    //Icons.school, "Institución", convocatoria.institucion),
                    _detalleItem(Icons.category, "Tipo", convocatoria.tipo),
                    _detalleItem(Icons.language, "Nivel Idioma",
                        convocatoria.nivelIdioma),
                    _detalleItem(Icons.timeline, "Promedio",
                        convocatoria.promedioMinimo.toString()),
                    _detalleItem(Icons.date_range, "Fechas",
                        "${convocatoria.fechaInicio.toString()} - ${convocatoria.fechaFin.toString()}"),
                    _detalleItem(Icons.description, "Descripción",
                        convocatoria.descripcion,
                        multiline: true),
                    _detalleItem(
                        Icons.assignment, "Requisitos", convocatoria.requisitos,
                        multiline: true),
                    _detalleItem(Icons.card_giftcard, "Beneficios",
                        convocatoria.beneficios,
                        multiline: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: const Text(
                      "Reviews",
                      style: TextStyle(
                        fontSize: 18,
                        color: SystemColors.primaryPrink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: const Text(
                      "Ir al Chat",
                      style: TextStyle(
                        fontSize: 18,
                        color: SystemColors.primaryGreenDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16)),
                child: const Text(
                  "Postularme",
                  style: TextStyle(
                    fontSize: 18,
                    color: SystemColors.primaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
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
