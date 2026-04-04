import 'package:hm_flutter_base/core/constants/app_end_point.dart';

class RoutesMock {
  static const String _base = 'assets/mocks';

  // Usamos una combinación de "METODO:Ruta" para mayor precisión
  static final Map<String, String> endpoints = {
    // Auth
    'POST:${AppEndPoint.login.login}': '$_base/auth/login_success.json',

    // Products
    'GET:/products': '$_base/products/get_all.json',
    'GET:/products/1': '$_base/products/get_detail_1.json',

    // User
    'GET:/user/profile': '$_base/user/profile.json',
  };
}
