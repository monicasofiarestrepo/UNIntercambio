import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:un_intercambio/data/repositories/candidato_repository.dart';
import '../models/candidato.dart';

final candidatosProvider = FutureProvider.family<List<Candidato>, int>((ref, convocatoriaId) async {
  final repository = CandidatoRepository();
  return repository.fetchCandidatosPorConvocatoria(convocatoriaId);
});
