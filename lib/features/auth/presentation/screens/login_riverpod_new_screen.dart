import 'package:base_flutter/core/common/provider/session_provider.dart';
import 'package:base_flutter/core/constants/app_contans.dart';
import 'package:base_flutter/core/theme/app_theme.dart';
import 'package:base_flutter/core/utils/alerts.dart';
import 'package:base_flutter/features/auth/data/sources/auth_api.dart';
import 'package:base_flutter/features/auth/presentation/provider/auth_riverpod.dart';
import 'package:base_flutter/features/auth/presentation/provider/auth_riverpod_new.dart';
import 'package:base_flutter/features/auth/presentation/widgets/login_background_widget.dart';
import 'package:base_flutter/features/auth/presentation/widgets/card_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginRiverpodNewScreen extends ConsumerWidget {
  const LoginRiverpodNewScreen({super.key});

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
                    'Inicio de sesión (Riverpod New)',
                    style: AppTheme.initLoginTitle,
                  ),
                  const SizedBox(height: 15),
                  const _LoginFormRiverpodNew(), // No necesitamos el ChangeNotifierProvider aquí
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

class _LoginFormRiverpodNew extends ConsumerWidget {
  const _LoginFormRiverpodNew();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuchamos el ESTADO (como un computed de Vue)
    // esto escucha (userName, password, isLoading, errorMessage)
    final authState = ref.watch(authRiverpodProviderNew);

    // Referencia al notifier para cambiar el estado (como el '.state++')
    final authNotifier = ref.read(authRiverpodProviderNew.notifier);

    return Column(
      children: [
        TextField(
          onChanged: (val) =>
              authNotifier.state = authState.copyWith(userName: val),
          decoration: const InputDecoration(
            labelText: 'Usuario',
            prefixIcon: Icon(Icons.account_circle),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          onChanged: (val) =>
              authNotifier.state = authState.copyWith(password: val),
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
            disabledBackgroundColor:
                Colors.grey, // color cuando está deshabilitado
          ),
          onPressed: authState.isLoading
              ? null
              : () async {
                  print('press button');
                  // quitamos el techado
                  FocusScope.of(context).unfocus();

                  // Lógica de Login "estilo directo"
                  authNotifier.state = authState.copyWith(isLoading: true);

                  try {
                    final response = await AuthApi().login(
                      authState.userName,
                      authState.password,
                    );

                    authNotifier.state = authState.copyWith(isLoading: false);

                    if (response == null) return;

                    if (response.isAuthenticated) {
                      mostrarAlert(context, "OK", typeAlert.ok);

                      // guardamos los datos en el store
                      ref
                          .read(sessionProvider.notifier)
                          .updateSession(response);

                      // Navegamos a la pantalla principal
                      Navigator.pushReplacementNamed(context, AppRoutesScreen.homeGrid);
                      return;
                    } else {
                      mostrarAlert(context, response.message, typeAlert.error);
                    }
                  } catch (e) {
                    authNotifier.state = authState.copyWith(
                      isLoading: false,
                      errorMessage: "Error",
                    );
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
