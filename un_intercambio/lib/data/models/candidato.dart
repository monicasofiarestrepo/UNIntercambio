class Candidato {
  final int id;
  final String nombre;
  final String programa;
  final String semestre;
  final String correo;

  Candidato({
    required this.id,
    required this.nombre,
    required this.programa,
    required this.semestre,
    required this.correo,
  });

  factory Candidato.fromJson(Map<String, dynamic> json) {
    return Candidato(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      programa: json['programa'] as String,
      semestre: json['semestre'].toString(),
      correo: json['correo'] as String,
    );
  }
}
