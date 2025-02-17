import 'package:flutter/material.dart';
import 'package:un_intercambio/features/base_page.dart';
import 'package:un_intercambio/features/widgets/bottom_nav_bar.dart';
import 'package:fl_chart/fl_chart.dart';

//TODO Arreglar la tabla
//TODO hacer que cuando se abran las nuevas paginas se deseleccione el home
//TODO revisar si se pueden utilizar widgets o colores ya creados

class MetricPage extends StatelessWidget {
  final String title;

  const MetricPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo para las métricas
    final data = [
      ConvocatoriaMetric(
        nombre: 'Intercambio a España 2024',
        personasPresentadas: 50,
        tasaDeAprobacion: 80,
        numeroDePaises: 5,
        promedioDeEdad: 24,
        porcentajeHombres: 60,
        porcentajeMujeres: 40,
        nivelAcademico: 'Licenciatura',
        costoPromedio: 1200,
        tasaDeParticipacion: 75,
      ),
      ConvocatoriaMetric(
        nombre: 'Programa de intercambio Alemania',
        personasPresentadas: 20,
        tasaDeAprobacion: 85,
        numeroDePaises: 3,
        promedioDeEdad: 23,
        porcentajeHombres: 70,
        porcentajeMujeres: 30,
        nivelAcademico: 'Maestría',
        costoPromedio: 1400,
        tasaDeParticipacion: 65,
      ),
      ConvocatoriaMetric(
        nombre: 'Intercambio con Japón',
        personasPresentadas: 35,
        tasaDeAprobacion: 90,
        numeroDePaises: 7,
        promedioDeEdad: 26,
        porcentajeHombres: 50,
        porcentajeMujeres: 50,
        nivelAcademico: 'Doctorado',
        costoPromedio: 1600,
        tasaDeParticipacion: 80,
      ),
    ];

    // Colores para las categorías
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
    ];

    // Preparamos los datos para el gráfico de torta
    List<PieChartSectionData> sections = data
        .asMap()
        .map((index, metric) {
          return MapEntry(
            index,
            PieChartSectionData(
              color: colors[index],  // Color único por categoría
              value: metric.personasPresentadas.toDouble(),
              title: '${metric.personasPresentadas}%', // Título con el porcentaje
              radius: 100,
              titleStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Color del título
              ),
            ),
          );
        })
        .values
        .toList();

    return BasePage(
      currentIndex: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(  // Aquí se hace el contenido desplazable
          child: Column(
            children: [
              const SizedBox(height: 150),
              const Text(
                'Visualización de Métricas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Gráfico de torta con fl_chart
              SizedBox(
                height: 300,
                child: PieChart(
                  PieChartData(
                    sections: sections,
                    centerSpaceRadius: 0, // Espacio en el centro de la torta
                    borderData: FlBorderData(show: false), // Sin borde
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Leyenda de colores envuelta en SingleChildScrollView para que sea desplazable
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,  // Permite desplazarse horizontalmente
                child: Column(
                  children: List.generate(
                    data.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            color: colors[index], // Color de la leyenda
                          ),
                          const SizedBox(width: 8),
                          Text(
                            data[index].nombre,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Tabla de métricas (todos los campos)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,  // Permite desplazarse horizontalmente
                child: DataTable(
                  columnSpacing: 12,  // Espaciado entre columnas
                  headingRowHeight: 56,  // Altura de la fila de encabezado
                  dataRowHeight: 60,  // Altura de las filas de datos
                  columns: const [
                    DataColumn(label: Text('Convocatoria', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Personas Presentadas', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Tasa de Aprobación', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Número de Países', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Edad Promedio', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Porcentaje Hombres', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Porcentaje Mujeres', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Nivel Académico', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Costo Promedio', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Tasa de Participación', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: data
                      .map(
                        (metric) => DataRow(
                          cells: [
                            DataCell(Text(metric.nombre)),
                            DataCell(Text('${metric.personasPresentadas}')),
                            DataCell(Text('${metric.tasaDeAprobacion}%')),
                            DataCell(Text('${metric.numeroDePaises}')),
                            DataCell(Text('${metric.promedioDeEdad}')),
                            DataCell(Text('${metric.porcentajeHombres}%')),
                            DataCell(Text('${metric.porcentajeMujeres}%')),
                            DataCell(Text(metric.nivelAcademico)),
                            DataCell(Text('\$${metric.costoPromedio}')),
                            DataCell(Text('${metric.tasaDeParticipacion}%')),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Clase para representar los datos de las convocatorias
class ConvocatoriaMetric {
  final String nombre;
  final int personasPresentadas;
  final double tasaDeAprobacion;
  final int numeroDePaises;
  final double promedioDeEdad;
  final double porcentajeHombres;
  final double porcentajeMujeres;
  final String nivelAcademico;
  final double costoPromedio;
  final double tasaDeParticipacion;

  ConvocatoriaMetric({
    required this.nombre,
    required this.personasPresentadas,
    required this.tasaDeAprobacion,
    required this.numeroDePaises,
    required this.promedioDeEdad,
    required this.porcentajeHombres,
    required this.porcentajeMujeres,
    required this.nivelAcademico,
    required this.costoPromedio,
    required this.tasaDeParticipacion,
  });
}
