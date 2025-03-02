import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/candidato.dart';

class CandidatoRepository {
  final String baseUrl = 'https://backend-devmovil.onrender.com/candidatos/';

  Future<List<Candidato>> fetchCandidatosPorConvocatoria(int convocatoriaId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/convocatorias/$convocatoriaId/candidatos'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Candidato.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los candidatos');
    }
  }
}
