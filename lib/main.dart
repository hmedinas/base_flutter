import 'package:hm_flutter_base/core/common/provider/app_state_provider.dart';
import 'package:hm_flutter_base/core/config/config_reader.dart';
import 'package:hm_flutter_base/core/router/app_router.dart';
import 'package:hm_flutter_base/core/theme/app_theme.dart';
import 'package:hm_flutter_base/core/utils/console.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';


void main() async {

    // 1. Inicializamos los WidgetsFlutterBinding, para acceder a los assets antes de arrancar la aplicacion. 
    WidgetsFlutterBinding.ensureInitialized();

    // 2. Iniciando la configuración según el entorno (inyectado por --dart-define)
    const env = String.fromEnvironment(
        'ENVIRONMENT',
        defaultValue: 'dev',
    );

    // Inicializamos el ConfigReader con el entorno deseado (se lee el JSON de assets)
    try
    {
        await ConfigReader.initialize(environment: env);
        await Console.initialize();
    } 
    catch (e) {
        debugPrint('Error crítico inicializando configuración: $e');
    }
  
    // TODO: esto es solo si usamos provider
    /*
    runApp(
        AppStateProvider(
            child: MainApp(environment: env)
            )
        );
        */

    // TODO: esto es solo si usamos riverpod
    /*
    runApp(
        const ProviderScope(
            child: MainApp(environment: env)
            )
        );
      */

    // TODO: esto es solo si usamos riverpod y provider
    runApp(
    // 1. Riverpod envuelve a todos (es el más externo)
    const ProviderScope(
      // 2. Tu AppState de Provider (el que ya tienes)
      child: AppStateProvider(
         child: MainApp(environment: env)
      ),
    ),
  );
 
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
