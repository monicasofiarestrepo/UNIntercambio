import '../models/postulacion.dart';
import '../repositories/postulation_repository.dart';

class PostulacionService {
  final PostulacionRepository _repository;

  PostulacionService(this._repository);

  Future<List<Postulacion>> obtenerPostulaciones({String? correo}) {
    return _repository.obtenerPostulaciones(correo: correo);
  }

  Future<bool> postular(Postulacion postulacion) {
    return _repository.enviarPostulacion(postulacion);
  }
}
