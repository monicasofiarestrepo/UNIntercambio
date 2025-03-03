class Postulacion {
  final String id;
  final String correoElectronico;
  final String idConvocatoria;
  final String estado;
  final double promedio;
  final int porcentajeAvance;
  final String carrera;
  final String idiomas;
  final String celular;
  final String nombreConvocatoria;
  final String descripcion;
  final String pais;
  final DateTime createdAt;
  final DateTime updatedAt;

  Postulacion({
    this.id = '',
    this.correoElectronico = '',
    this.idConvocatoria = '',
    this.estado = 'Pendiente',
    this.promedio = 0.0,
    this.porcentajeAvance = 0,
    this.carrera = 'No especificado',
    this.idiomas = 'No especificado',
    this.celular = 'No disponible',
    this.nombreConvocatoria = '',
    this.descripcion = '',
    this.pais = 'No disponible',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Postulacion.fromJson(Map<String, dynamic> json) {
    return Postulacion(
      id: json['_id'] ?? '',
      correoElectronico: json['correoElectronico'] ?? '',
      idConvocatoria: json['idConvocatoria'] ?? '',
      estado: json['estado'] ?? 'Pendiente',
      promedio: (json['promedio'] is num) ? json['promedio'].toDouble() : 0.0,
      porcentajeAvance: (json['porcentajeAvance'] is int) ? json['porcentajeAvance'] : 0,
      carrera: json['carrera'] ?? 'No especificado',
      idiomas: json['idiomas'] ?? 'No especificado',
      celular: json['celular'] ?? 'No disponible',
      nombreConvocatoria: json['nombreConvocatoria'] ?? '',
      descripcion: json['descripcion'] ?? '',
      pais: json['pais'] ?? 'No disponible',
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) ?? DateTime.now() : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) ?? DateTime.now() : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'correoElectronico': correoElectronico,
      'idConvocatoria': idConvocatoria,
      'estado': estado,
      'promedio': promedio,
      'porcentajeAvance': porcentajeAvance,
      'carrera': carrera,
      'idiomas': idiomas,
      'celular': celular,
      'nombreConvocatoria': nombreConvocatoria,
      'descripcion': descripcion,
      'pais': pais,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}