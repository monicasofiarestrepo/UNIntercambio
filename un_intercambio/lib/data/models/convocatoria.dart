class Convocatoria {
  final String? id;
  final String? idConvocatoria;
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
    this.id,
    this.idConvocatoria,
    this.nombre = 'Sin nombre',
    this.tipo = 'Desconocido',
    this.descripcion = '',
    this.requisitos = '',
    this.promedioMinimo = 0.0,
    this.nivelIdioma = 'No especificado',
    this.beneficios = '',
    DateTime? fechaInicio,
    DateTime? fechaFin,
    this.estado = 'Desconocido',
  })  : fechaInicio = fechaInicio ?? DateTime.now(),
        fechaFin = fechaFin ?? DateTime.now();

  factory Convocatoria.fromJson(Map<String, dynamic> json) {
    return Convocatoria(
      id: json['_id'] as String?,
      idConvocatoria: json['idConvocatoria']?.toString(),
      nombre: json['nombre'] ?? 'Sin nombre',
      tipo: json['tipo'] ?? 'Desconocido',
      descripcion: json['descripcion'] ?? '',
      requisitos: json['requisitos'] ?? '',
      promedioMinimo: (json['promedioMinimo'] as num?)?.toDouble() ?? 0.0,
      nivelIdioma: json['nivelIdioma'] ?? 'No especificado',
      beneficios: json['beneficios'] ?? '',
      fechaInicio: json['fechaInicio'] != null
          ? DateTime.tryParse(json['fechaInicio']) ?? DateTime.now()
          : DateTime.now(),
      fechaFin: json['fechaFin'] != null
          ? DateTime.tryParse(json['fechaFin']) ?? DateTime.now()
          : DateTime.now(),
      estado: json['estado'] ?? 'Desconocido',
    );
  }
}
