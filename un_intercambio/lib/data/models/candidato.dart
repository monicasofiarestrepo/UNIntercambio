class Candidato {
  final int id;
  final String nombre;
  final String programa;
  final String correo;
  final double promedio;

  Candidato({
    required this.id,
    required this.nombre,
    required this.programa,
    required this.correo,
    required this.promedio,
  });

  factory Candidato.fromJson(Map<String, dynamic> json) {
    return Candidato(
      id: int.parse(json['id'].toString()), // Aquí corregimos el id
      nombre: json['nombre'] as String,
      correo: json['correo'] as String,
      programa: json['programa'] ?? 'Desconocido',
      promedio: (json['promedio'] as num).toDouble(),
    );
  }
}
