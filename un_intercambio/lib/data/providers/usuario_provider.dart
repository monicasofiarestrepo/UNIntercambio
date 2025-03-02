import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:un_intercambio/data/repositories/usuario_repository.dart';
import 'package:un_intercambio/data/models/usuario.dart';
import 'package:un_intercambio/core/global_variables.dart'; // Se usa para acceder al emailUserProvider

final usuarioRepositoryProvider = Provider((ref) {
  return UsuarioRepository();
});

// 🔹 Provider para obtener la lista de todos los usuarios
final usuarioProvider = FutureProvider<List<Usuario>>((ref) async {
  final repository = ref.watch(usuarioRepositoryProvider);
  return repository.fetchUsuarios();
});

// 🔹 Nuevo provider que obtiene SOLO el usuario logueado basado en su correo
final usuarioActualProvider = FutureProvider<Usuario?>((ref) async {
  final repository = ref.watch(usuarioRepositoryProvider);
  final email = ref.watch(emailUserProvider);

  if (email.isEmpty) return null; // Si no hay correo registrado, retorna null

  return repository.fetchUsuarioPorCorreo(email);
});
