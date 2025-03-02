import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:un_intercambio/data/repositories/usuario_repository.dart';
import 'package:un_intercambio/data/models/usuario.dart';

final usuarioRepositoryProvider = Provider((ref) {
  return UsuarioRepository();
});

final usuarioProvider = FutureProvider<List<Usuario>>((ref) async {
  final repository = ref.watch(usuarioRepositoryProvider);
  return repository.fetchUsuarios();
});
