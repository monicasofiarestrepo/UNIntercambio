import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:un_intercambio/data/providers/usuario_provider.dart';

final isEstudianteProvider = StateProvider<bool>((ref) {
  final usuarioAsync = ref.watch(usuarioProvider);

  return usuarioAsync.when(
    data: (usuarios) {
      if (usuarios.isEmpty) return false;
      return usuarios.first.tipoUsuario == "student";
    },
    loading: () => false,
    error: (_, __) => false,
  );
});

bool getIsEstudiante(WidgetRef ref) {
  return ref.read(isEstudianteProvider);
}
