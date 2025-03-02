class Usuario {
  final String id;
  final String nombre;
  final String correo;
  final String contrasena;
  final String tipoUsuario;

  Usuario({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.contrasena,
    required this.tipoUsuario,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['_id'],
      nombre: json['nombre'],
      correo: json['correo'],
      contrasena: json['contrasena'],
      tipoUsuario: json['tipoUsuario'],
    );
  }
}
