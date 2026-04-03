import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'app_config.dart'; // Importa tus clases de modelos

class ConfigReader {
  static  AppConfig? _config;
  // Guardamos el entorno aquí al inicializar
  static late String _environment;

  // Inicialización: Transforma el JSON directamente en el Modelo
  static Future<void> initialize({required String environment}) async {
    _environment = environment; // Lo guardamos
    try {
      final configString = await rootBundle.loadString(
        'assets/config/config_$environment.json',
      );
      final Map<String, dynamic> jsonMap = json.decode(configString);

      // convertimos el mapa al objeto.
      _config = AppConfig.fromJson(jsonMap);
    } catch (e) {
      throw Exception('Error cargando la configuración ($environment): $e');
    }
  }

  // Getter global para acceder a TODA la configuración con autocompletado
  static AppConfig get config {
    if (_config == null) {
      throw Exception(
        'ConfigReader no ha sido inicializado. Llama a initialize() en el main.',
      );
    }
    return _config!;
  }

  static bool get viewLog => config.app.viewLog;
  static String get currentEnv => _environment;
  static String get baseUrl => config.api.baseUrl;
  static String get baseAuthUrl => config.api.authUrl;
  static String get logLevel => config.app.logLevel;
}
