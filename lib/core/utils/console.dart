import 'dart:convert';
import 'package:hm_flutter_base/core/config/app_config.dart';
import 'package:hm_flutter_base/core/config/config_reader.dart';
import 'package:flutter/services.dart';

class Console {
  static bool _showLogs = false;

  // 1. Inicialización: Carga el JSON una sola vez al inicio
  static Future<void> initialize() async {
    try {
     
      _showLogs = ConfigReader.viewLog;
       print( '⚠️ Log Activados');
    
    } catch (e) {
      _showLogs = false;
      print( '⚠️ Error en Console: $e');

    }
  }

  // 2. El método Log principal
  static void log(dynamic message, {String layer = 'APP'}) {
    if (!_showLogs) return;

    // Obtenemos la información de quién llamó (Archivo y Línea)
    // El índice [1] suele ser la función que llamó a 'log'
    final stackTrace = StackTrace.current.toString().split('\n');
    final callerInfo = _parseStackTrace(stackTrace[1]);

    // Colores ANSI para la consola de VS Code/Android Studio
 

    print('[$layer] | ${callerInfo['file']}:${callerInfo['line']} | => $message');
  }

  // Helper para extraer el archivo y línea del StackTrace
  static Map<String, String> _parseStackTrace(String line) {
    try {
      final matches = RegExp(r'package:.*:(\d+):(\d+)').firstMatch(line);
      if (matches != null) {
        final fullPath = matches.group(0) ?? '';
        final fileName = fullPath.split('/').last.split(':').first;
        final lineNumber = matches.group(1) ?? '0';
        return {'file': fileName, 'line': lineNumber};
      }
    } catch (_) {}
    return {'file': 'unknown', 'line': '0'};
  }
}
