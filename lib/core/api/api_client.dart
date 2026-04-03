import 'package:dio/dio.dart';
import 'package:base_flutter/core/config/config_reader.dart';

class ApiClient {
  late Dio dio;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ConfigReader.config.api.authUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
        
          if (ConfigReader.config.app.viewLog) {
            print('--> ${options.method} ${options.path}');
          }
          // 1. Intentamos obtener el token (de SharedPreferences o SecureStorage)
          // final token = await _storage.read(key: 'token');
          const String? token = null; // Simulación para el Login inicial

          // 2. Si el token existe, lo añadimos. Si no (como en el Login), no pasa nada.
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          
          options.headers['Content-Type'] = 'application/json';
          options.headers['Accept'] = 'application/json';

          return handler.next(options); // Continúa la petición
        },
        onError: (DioException e, handler) {
          // Si la API responde 401, aquí puedes limpiar el storage y mandar al Login
          if (e.response?.statusCode == 401) {
            print('Sesión expirada');
          }
          return handler.next(e);
        },
      ),
    );
  }
}