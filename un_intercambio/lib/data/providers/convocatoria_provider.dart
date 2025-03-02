import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:un_intercambio/data/repositories/convocatoria_repository.dart';
import 'package:un_intercambio/data/models/convocatoria.dart';

final convocatoriaRepositoryProvider = Provider((ref) {
  return ConvocatoriaRepository();
});

final convocatoriaProvider = FutureProvider<List<Convocatoria>>((ref) async {
  final repository = ref.watch(convocatoriaRepositoryProvider);
  return repository.fetchConvocatorias();
});
