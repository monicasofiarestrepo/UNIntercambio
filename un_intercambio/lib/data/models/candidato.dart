class Candidato {
  final int id;
  final String nombre;
  final String programa;
  final String semestre;
  final String correo;
  final double avance;
  final double promedio;

  Candidato({
    required this.id,
    required this.nombre,
    required this.programa,
    required this.semestre,
    required this.correo,
    required this.avance,
    required this.promedio,
  });

  factory Candidato.fromJson(Map<String, dynamic> json) {
    return Candidato(
      id: int.parse(json['id'].toString()), // Aquí corregimos el id
      nombre: json['nombre'] as String,
      programa: json['programa'] as String,
      semestre: json['semestre'].toString(),
      correo: json['correo'] as String,
      avance: (json['avance'] as num).toDouble(),
      promedio: (json['promedio'] as num).toDouble(),
    );
  }
}
