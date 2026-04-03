import 'package:base_flutter/features/auth/data/models/login_response_model.dart';
import 'package:base_flutter/features/auth/data/sources/auth_api.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
    final AuthApi _authService;

    AuthProvider(this._authService);

    String _userName = '';
    String _password = '';
    bool _isLoading = false;
    String? _errorMessage;

    // Getters
    String get userName => _userName;
    String get password => _password;
    bool get isLoading => _isLoading;
    String? get errorMessage => _errorMessage;

    // Setters con lógica de limpieza de errores automática
    void setUserName(String value) {
        _userName = value;
        _errorMessage = null; // Si el usuario vuelve a escribir, el error viejo desaparece
        notifyListeners();
    }

    void setPassword(String value) {
        _password = value;
        _errorMessage = null;
        notifyListeners();
    }

    // Validación rápida para el botón de la UI
     bool isValidForm() {
        return userName.trim().length >= 3 && password.trim().length >= 3;
    }

    /// Método para resetear el estado (útil al cerrar sesión o salir del login)
    void clear() {
        _userName = '';
        _password = '';
        _errorMessage = null;
        _isLoading = false;
        notifyListeners();
    }

    Future<LoginResponseModel?> login() async {
    if (!isValidForm()) {
      _errorMessage = "Usuario o contraseña muy cortos";
      notifyListeners();
      return null;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Avisamos que empezó a cargar

    try {
      final response = await _authService.login(_userName, _password);

      // Lógica de códigos de respuesta según tu API
      if (response.statusCode != 200 && response.statusCode != 300) {
        _errorMessage = response.message;
      }
      
      return response;
    } catch (e) {
      _errorMessage = "Error de conexión con el servidor";
      return null;
    } finally {
      // El 'finally' asegura que pase lo que pase, el loading se detenga
      _isLoading = false;
      notifyListeners();
    }
  }
}