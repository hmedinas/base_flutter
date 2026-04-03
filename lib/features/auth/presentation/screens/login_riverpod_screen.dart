import 'package:base_flutter/core/constants/app_contans.dart';
import 'package:base_flutter/core/theme/app_theme.dart';
import 'package:base_flutter/core/utils/alerts.dart';
import 'package:base_flutter/features/auth/presentation/provider/auth_riverpod.dart';
import 'package:base_flutter/features/auth/presentation/widgets/login_background_widget.dart';
import 'package:base_flutter/features/auth/presentation/widgets/card_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginRiverpodScreen extends ConsumerWidget {
  const LoginRiverpodScreen({super.key});

  @override
  // se agrega el WidgetRef pra usar riverpod
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: LoginBackgroundWidget(
        child: Column(
          children: [
            const SizedBox(height: 180),
            CardContainerWidget(
              child: Column(
                children: [
                  const SizedBox(
                    width: 190,
                    height: 55,
                    child: Image(
                      image: AssetImage(AppAssets.logo),
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Inicio de sesión (Riverpod)',
                    style: AppTheme.initLoginTitle,
                  ),
                  const SizedBox(height: 15),
                  const _LoginFormRiverpod(), // No necesitamos el ChangeNotifierProvider aquí
                  const SizedBox(height: 15),
                  // ... el resto igual
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginFormRiverpod extends ConsumerWidget {
  const _LoginFormRiverpod();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuchamos el ESTADO (como un computed de Vue)
    // esto escucha (userName, password, isLoading, errorMessage)
    final authState = ref.watch(authRiverpodProvider);

    // Accedemos a la LÓGICA (los métodos)
    final authLogic = ref.read(authRiverpodProvider.notifier);

    return Column(
      children: [
        TextField(
          onChanged: authLogic.setUserName,
          decoration: const InputDecoration(
            labelText: 'Usuario',
            prefixIcon: Icon(Icons.account_circle),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          onChanged: authLogic.setPassword,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Contraseña',
            prefixIcon: Icon(Icons.lock),
          ),
        ),
        const SizedBox(height: 25),
        // usamos el isloadin para controlar el boton
        ElevatedButton( 
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonPrimary, // color normal
            foregroundColor: Colors.white, // texto
            disabledBackgroundColor: Colors.grey, // color cuando está deshabilitado
          ),
          onPressed: authState.isLoading
              ? null
              : () async {
                   print('press button');
                   // quitamos el techado
                  FocusScope.of(context).unfocus();

                  if (!authLogic.isValidForm()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Usuario o contraseña inválidos')),
                    );
                    return;
                  }

                  // Llamar login
                  final response = await authLogic.login();

                  if (response == null) 
                    return;
                    
                  if (response.isAuthenticated) {
                    mostrarAlert(context, "OK", typeAlert.ok);
                  } else {
                    mostrarAlert(context, response.message, typeAlert.error);
                  }
                },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            child: Text(
              authState.isLoading ? 'Espere ...' : 'Ingresar',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ],
    );

  }
}
