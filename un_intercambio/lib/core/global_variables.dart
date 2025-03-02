import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:un_intercambio/data/providers/usuario_provider.dart';

final isEstudianteProvider = StateProvider<bool>((ref) {
  final usuarioAsync =
      ref.watch(usuarioActualProvider); // 🔹 Ahora observa el usuario logueado

  return usuarioAsync.when(
    data: (usuario) {
      if (usuario == null)
        return false; // Si no hay usuario logueado, retorna false
      print("Usuario autenticado: ${usuario.tipoUsuario}"); // Depuración
      return usuario.tipoUsuario == "student";
    },
    loading: () => false,
    error: (_, __) => false,
  );
});

bool getIsEstudiante(WidgetRef ref) {
  return ref.read(isEstudianteProvider);
}

final emailUserProvider = StateProvider<String>(
    (ref) => ''); //en el login se actualiza con el email del usuario
