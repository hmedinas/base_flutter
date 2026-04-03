import 'package:base_flutter/core/config/config_reader.dart';
import 'package:base_flutter/core/router/app_router.dart';
import 'package:base_flutter/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() async {

    // 1. Inicializamos los WidgetsFlutterBinding, para acceder a los assets antes de arrancar la aplicacion. 
    WidgetsFlutterBinding.ensureInitialized();

    // 2. Iniciando la configuración según el entorno (inyectado por --dart-define)
    const environment = String.fromEnvironment(
        'ENVIRONMENT',
        defaultValue: 'dev',
    );

    // Inicializamos el ConfigReader con el entorno deseado (se lee el JSON de assets)
    try
    {
        await ConfigReader.initialize(environment: environment);
    } 
    catch (e) {
        debugPrint('Error crítico inicializando configuración: $e');
    }
  

  runApp(const MainApp(environment: environment,));
}

class MainApp extends StatelessWidget {
    final String environment;
    const MainApp({super.key, required this.environment});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Proyecto Base',
            theme: AppTheme.baseTheme,
            initialRoute: AppRouter.initialRoute(environment),
            onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings, environment),
        );
    }
}
