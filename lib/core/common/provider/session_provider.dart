
// creamos un provider Global
import 'package:hm_flutter_base/core/common/domain/entities/business_models.dart';
import 'package:hm_flutter_base/core/common/domain/entities/user_models.dart';
import 'package:hm_flutter_base/core/utils/console.dart';
import 'package:hm_flutter_base/features/auth/data/models/login_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Recuerda no usam os StateProvider.autoDispose porque esto son datos como en pinia que tiene que persstir en memoria 
final sessionProvider = NotifierProvider<SessionNotifier, LoginResponseModel?>(() {
  return SessionNotifier();
});

class SessionNotifier extends Notifier<LoginResponseModel?> {

  @override
  LoginResponseModel? build() {
    // Estado inicial: null (nadie está logueado aún)
    return null;
  }

  // Accion 1: Guardar Datos despues del login
  void updateSession(LoginResponseModel? userData) {
    state = userData;
  }

  // Accion 2: Seleccionar una empresa
  void setBusiness(BusinessModels empresa) {
    if (state != null) {
      // "Copiamos" el estado actual pero cambiando solo la empresa seleccionada
      state = state!.copyWith(businessSelectModels: empresa);
      
      Console.log('🏢 Empresa seleccionada: ${empresa.empresa}', layer: 'SESSION');
    }
  }

  // Cerrar sesión
  void logout() {
    state = null;
  }



  // Verificar si el usuario tiene un rol específico
  bool hasRole(String role) {
    final user = state?.user;
    return user != null && user.roles.contains(role);
  }

  // Verificar si el usuario tiene algún rol de una lista
  bool hasAnyRole(List<String> roles) {
    final user = state?.user;
    return user != null && roles.any(user.roles.contains);
  }

  // Verificar si el usuario tiene todos los roles de una lista
  bool hasAllRoles(List<String> roles) {
    final user = state?.user;
    return user != null && roles.every(user.roles.contains);
  }

 
 
  // Verificar si hay sesión activa
  // bool isLogged() => state?.isAuthenticated ?? false;
    bool get isLogged => state?.isAuthenticated ?? false; 
    String? get token => state?.accessToken;
    UserModels? get user => state?.user;

  // Obtener datos del usuario logueado
  UserModels? getUserData() => state?.user;

  // Obtener el token de acceso
  String? getAccessToken() => state?.accessToken;

}