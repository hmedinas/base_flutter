import 'dart:convert';
import 'dart:io';

import 'package:base_flutter/core/mock/routes_mock.dart';
import 'package:base_flutter/core/utils/console.dart';
import 'package:dio/dio.dart';
import 'package:base_flutter/core/config/config_reader.dart';
import 'package:dio/io.dart';
import 'package:flutter/services.dart';

class ApiClient {
  late Dio dio;
  final String _layer = 'ApiClient';

  ApiClient({
     String? jwtToken,
     bool ignoreSSL = false,
  }) {
    dio = Dio(
      BaseOptions(
        baseUrl: ConfigReader.config.api.authUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (jwtToken != null) 'Authorization': 'Bearer $jwtToken',
        },
      ),
    );


     // Permitir ignorar SSL (solo si lo indicas explícitamente)
    /*
    if (ignoreSSL) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    */
    if (ignoreSSL) {
        dio.httpClientAdapter = IOHttpClientAdapter(
            createHttpClient: () {
            final client = HttpClient();
            client.badCertificateCallback = (cert, host, port) => true;
            return client;
            },
        );
    }

    // 2. Añadimos los interceptores comunes (Logs, Tokens)
    _setupCommonInterceptors();

    // vemos si vamos a usar mock o no
    if (ConfigReader.config.app.useMock) {
      _setupMockInterceptorComplete();
    }

  }

  void _setupCommonInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
         
            Console.log('🌐 [API REQ] ${options.method} -> ${options.uri}', layer: _layer);
            Console.log('Headers: ${options.headers}', layer: _layer);
            Console.log('Body: ${options.data}', layer: _layer);
          
          // 1. Intentamos obtener el token (de SharedPreferences o SecureStorage)
          // final token = await _storage.read(key: 'token');
          const String? token = null; // Simulación para el Login inicial

          // 2. Si el token existe, lo añadimos. Si no (como en el Login), no pasa nada.
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options); // Continúa la petición
        },
        onResponse: (response, handler) {
            Console.log('[RESPONSE] ${response.statusCode} ${response.data}', layer: _layer);
            
            return handler.next(response);
        },
        onError: (DioException e, handler) {
          // Si la API responde 401, aquí puedes limpiar el storage y mandar al Login
          if (e.response?.statusCode == 401) {
            print('Sesión expirada');
          }

          Console.log('❌ [API ERR] ${e.response?.statusCode} -> ${e.message}', layer: _layer);

          return handler.next(e);
        },
      ),
    );
  }

  void _setupMockInterceptor() {
    // 1. Definimos un mapa de rutas y sus archivos JSON
    final Map<String, String> mockEndpoints = {
      '/login': 'assets/mocks/auth_success.json',
      '/user/profile': 'assets/mocks/user_profile.json',
      '/products/list': 'assets/mocks/products_list.json',
      '/settings': 'assets/mocks/settings_default.json',
    };

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Buscamos si la ruta actual (path) existe en nuestro diccionario de mocks
          // Usamos .entries.firstWhere para permitir coincidencias parciales si es necesario
          final String? mockAssetPath = mockEndpoints.entries
              .where((entry) => options.path.contains(entry.key))
              .map((entry) => entry.value)
              .firstOrNull;

          if (mockAssetPath != null) {
            if (ConfigReader.config.app.viewLog) {
              Console.log(
                '🧪 [MOCK] Interceptando: ${options.path} -> Usando: $mockAssetPath',
                layer: _layer
              );
            }

            // Simulamos latencia
            await Future.delayed(const Duration(milliseconds: 600));

            try {
              final String response = await rootBundle.loadString(
                mockAssetPath,
              );
              final data = json.decode(response);

              return handler.resolve(
                Response(requestOptions: options, data: data, statusCode: 200),
              );
            } catch (e) {
                Console.log('⚠️ Error al leer el JSON: $e', layer: _layer);
                
              // Si falla el archivo, que intente ir a la red por si acaso
              return handler.next(options);
            }
          }

          // Si la ruta no está mapeada, continúa hacia el servidor real
          return handler.next(options);
        },
      ),
    );
  }

  void _setupMockInterceptorComplete() {
    final viewLog = ConfigReader.config.app.viewLog;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Creamos la llave de búsqueda: "POST:/login"
          final String lookupKey = '${options.method}:${options.path}';

          // Buscamos en el mapa
          final String? mockAssetPath = RoutesMock.endpoints[lookupKey];

          if (mockAssetPath != null) {
            // Log para saber que estamos usando un archivo local
            if (ConfigReader.config.app.viewLog) {
              Console.log( 
                '🧪 [MOCK] Cargando: $mockAssetPath',
                layer:_layer,
              );
            }

            // Latencia artificial
            await Future.delayed(const Duration(milliseconds: 600));

            try {
              final String response = await rootBundle.loadString(
                mockAssetPath,
              );
              final data = json.decode(response);

              return handler.resolve(
                Response(requestOptions: options, data: data, statusCode: 200),
              );
            } catch (e) {
                 Console.log('⚠️ Error al leer el JSON: $e', layer: _layer);
              return handler.next(options);
            }
          }

          // Si no hay mock, intentamos ir a la red real
          return handler.next(options);
        },
      ),
    );
  }

  // --------------------------------------------------------------
  // Métodos básicos
  // --------------------------------------------------------------

  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options}) async {
    return dio.get<T>(path,
        queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> post<T>(String path,
      {dynamic data, Options? options}) async {
    return dio.post<T>(path, data: data, options: options);
  }

  Future<Response<T>> put<T>(String path,
      {dynamic data, Options? options}) async {
    return dio.put<T>(path, data: data, options: options);
  }

  Future<Response<T>> delete<T>(String path, {Options? options}) async {
    return dio.delete<T>(path, options: options);
  }

  // --------------------------------------------------------------
  // Utilidades
  // --------------------------------------------------------------

  /// Permite actualizar el JWT dinámicamente
  void updateToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Permite remover el token actual
  void clearToken() {
    dio.options.headers.remove('Authorization');
  }

  /// Acceso directo a la instancia Dio (si lo necesitas)
  Dio get client => dio;

}
