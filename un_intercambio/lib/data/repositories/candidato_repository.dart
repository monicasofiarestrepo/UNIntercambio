import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/candidato.dart';

class CandidatoRepository {
  final String baseUrl = 'https://backend-devmovil.onrender.com/postulaciones/';

  Future<List<Candidato>> fetchCandidatosPorConvocatoria(String convocatoriaId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/convocatoria/$convocatoriaId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Candidato.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los candidatos');
    }
  }
}
