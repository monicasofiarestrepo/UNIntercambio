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
}
