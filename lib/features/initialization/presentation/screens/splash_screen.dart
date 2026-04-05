import 'package:hm_flutter_base/core/constants/app_contans.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final String env;
  const SplashScreen({super.key, required this.env});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  /// Lógica de redirección inicial
  Future<void> _navigateToNext() async {
    // 1. Simulamos una carga inicial (Check de versión, token, etc.)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // 2. Aquí es donde usarás tu lógica en el futuro:
    // bool hasToken = await _authService.hasToken();
    const bool hasToken = false; // Simulación

    if (hasToken) {
        Navigator.pushReplacementNamed(context, 'home');
    } 
    else {
      // Usamos pushReplacementNamed para que el usuario no pueda 
      // volver atrás al Splash con el botón del celular.
      Navigator.pushReplacementNamed(context, 'login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos el color de fondo definido en tus constantes
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo de la App
            Hero(
              tag: 'logo_app',
              child: Image.asset(
                AppAssets.logoSplash,
                width: 230,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.rocket_launch, 
                  size: 80, 
                  color: Colors.white
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            // Indicador de carga (estilo iOS/Android)
            const CircularProgressIndicator(
              color: Colors.white,
            ),
            
            const SizedBox(height: 20),
            
            // Etiqueta del entorno (Solo visible en dev/staging)
            if (widget.env != 'prod')
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'ENVIRONMENT: ${widget.env.toUpperCase()}',
                  style: const TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold,
                    fontSize: 10
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}