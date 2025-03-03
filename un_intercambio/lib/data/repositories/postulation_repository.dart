import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/postulacion.dart';

class PostulacionRepository {
  final String apiUrl = 'https://backend-devmovil.onrender.com/postulaciones';

  Future<List<Postulacion>> obtenerPostulaciones({String? correo}) async {
    String url = correo != null ? '$apiUrl/usuario/correo/$correo' : apiUrl;
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Postulacion.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener postulaciones');
    }
  }

  Future<bool> enviarPostulacion(Postulacion postulacion) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(postulacion.toJson()),
    );

    return response.statusCode == 201;
  }
}
