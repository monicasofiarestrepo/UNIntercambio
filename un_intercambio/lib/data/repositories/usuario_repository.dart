import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:un_intercambio/data/models/usuario.dart';

class UsuarioRepository {
  final String _baseUrl = 'https://backend-devmovil.onrender.com/personas/';

  Future<List<Usuario>> fetchUsuarios() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Usuario.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener usuarios');
    }
  }

  // 🔹 Nuevo método para obtener un solo usuario basado en el correo
  Future<Usuario?> fetchUsuarioPorCorreo(String correo) async {
    final Uri url = Uri.parse('$_baseUrl/buscar?correo=$correo');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Usuario.fromJson(data);
    } else {
      return null; // Si no se encuentra el usuario, retorna null
    }
  }
}
