class Convocatoria {
  final String id;
  final String idConvocatoria;
  final String nombre;
  final String tipo;
  final String descripcion;
  final String requisitos;
  final double promedioMinimo;
  final String nivelIdioma;
  final String beneficios;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final String estado;

  Convocatoria({
    required this.id,
    required this.idConvocatoria,
    required this.nombre,
    required this.tipo,
    required this.descripcion,
    required this.requisitos,
    required this.promedioMinimo,
    required this.nivelIdioma,
    required this.beneficios,
    required this.fechaInicio,
    required this.fechaFin,
    required this.estado,
  });

  factory Convocatoria.fromJson(Map<String, dynamic> json) {
    return Convocatoria(
      id: json['_id'],
      idConvocatoria: json['idConvocatoria'],
      nombre: json['nombre'],
      tipo: json['tipo'],
      descripcion: json['descripcion'],
      requisitos: json['requisitos'],
      promedioMinimo: (json['promedioMinimo'] as num).toDouble(),
      nivelIdioma: json['nivelIdioma'],
      beneficios: json['beneficios'],
      fechaInicio: DateTime.parse(json['fechaInicio']),
      fechaFin: DateTime.parse(json['fechaFin']),
      estado: json['estado'],
    );
  }
}
