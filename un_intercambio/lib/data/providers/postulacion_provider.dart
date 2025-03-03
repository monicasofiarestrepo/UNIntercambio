import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/postulacion_service.dart';
import '../repositories/postulation_repository.dart';
import '../models/postulacion.dart';

final postulacionRepositoryProvider = Provider((ref) => PostulacionRepository());
final postulacionServiceProvider = Provider(
  (ref) => PostulacionService(ref.read(postulacionRepositoryProvider)),
);

final postulacionesFutureProvider = FutureProvider<List<Postulacion>>((ref) {
  return ref.read(postulacionServiceProvider).obtenerPostulaciones();
});

final postularFutureProvider = FutureProvider.family<bool, Postulacion>((ref, postulacion) {
  return ref.read(postulacionServiceProvider).postular(postulacion);
});
