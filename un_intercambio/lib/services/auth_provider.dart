import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool isLoading = false;
  String? currentUser;
  final Map<String, String> _users = {}; // Base de datos local simulada

  String? register(String email, String password) {
    if (_users.containsKey(email)) return 'El correo ya está registrado.';
    _users[email] = password;
    currentUser = email;
    notifyListeners();
    return null;
  }

  String? login(String email, String password) {
    if (!_users.containsKey(email)) return 'Usuario no encontrado.';
    if (_users[email] != password) return 'Contraseña incorrecta.';
    currentUser = email;
    notifyListeners();
    return null;
  }

  void logout() {
    currentUser = null;
    notifyListeners();
  }
}
