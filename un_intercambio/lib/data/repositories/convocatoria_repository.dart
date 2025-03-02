import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:un_intercambio/data/models/convocatoria.dart';

class ConvocatoriaRepository {
  final String _baseUrl = 'https://backend-devmovil.onrender.com/convocatorias/';

  // Obtener todas las convocatorias
  Future<List<Convocatoria>> fetchConvocatorias() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Convocatoria.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener convocatorias');
    }
  }

  // Crear una nueva convocatoria
  Future<void> crearConvocatoria(Map<String, dynamic> convocatoria) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(convocatoria),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al registrar convocatoria: ${response.body}');
    }
  }
}
