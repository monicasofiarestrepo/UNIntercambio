class Candidato {
  final int id;
  final String nombre;
  final String programa;
  final String correo;
  final String avance;
  final double promedio;

  Candidato({
    required this.id,
    required this.nombre,
    required this.programa,
    required this.correo,
    required this.avance,
    required this.promedio,
  });

  factory Candidato.fromJson(Map<String, dynamic> json) {
    return Candidato(
      id: json['id'] != null ? int.parse(json['id'].toString()) : 0, // Si no viene id, poner 0
      nombre: json['nombre'] as String? ?? 'Desconocido',
      correo: json['correo'] as String? ?? 'Sin correo',
      programa: json['programa'] as String? ?? 'Desconocido',
      avance: json['avance'] != null ? json['avance'].toString() : '0', // Siempre String
      promedio: json['promedio'] != null
          ? (json['promedio'] as num).toDouble()
          : 0.0, // Si no viene, poner 0.0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'correo': correo,
      'programa': programa,
      'avance': avance,
      'promedio': promedio,
    };
  }
}
