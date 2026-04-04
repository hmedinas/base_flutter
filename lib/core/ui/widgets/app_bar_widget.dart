import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hm_flutter_base/core/common/provider/session_provider.dart';
import 'package:hm_flutter_base/core/constants/app_contans.dart';
import 'package:hm_flutter_base/core/theme/app_theme.dart';

class AppBarWidget extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1.- escuchamos el riverpod
    final user = ref.watch(sessionProvider);

    const Color sysIco = AppColors.appBarIcon;
    const Color sysTextTitle =  AppColors.appBarTextTitle;
    const Color sysTextSubTitle =  AppColors.appBarTextSubTitle;


    return AppBar(
      elevation: 0,
      backgroundColor: AppTheme.baseTheme.appBarTheme.backgroundColor,
      centerTitle: false,
      // 1. Reducimos el ancho del leading para que no "empuje" tanto el título
      // leadingWidth: 55, 
      // 2. IMPORTANTE: Quitamos el espacio automático entre leading y title
      titleSpacing: 7,
      // LADO IZQUIERDO: Avatar que abre el Drawer
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Center(
          // usamos InkWell y no materialbutton porque es mas ligero
            child: MaterialButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                color: const Color.fromARGB(196, 255, 26, 53), // Color de fondo del botón
                textColor: Colors.white,        // Color del icono
                elevation: 0,                    // Quitamos la sombra para que sea plano (Flat)
                highlightElevation: 0,           // Evitamos que suba al presionar
                shape: const CircleBorder(),     // Lo hacemos circular
                padding: EdgeInsets.all(5),        // ponemos padding interno extra
                child: const Icon(Icons.person, size: 30),
            ),
        ),
      ),

      // CENTRO: Datos obtenidos directamente del Provider
      title: Row(
        children: [
            // ESTA ES LA LÍNEA DIVISORIA (Como la del logo)
        Container(
          width: 3,             // Grosor de la línea
          height: 35,            // Altura de la línea
          decoration: BoxDecoration(
            color: Colors.white, // Color blanco como en el logo
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 7), // Espacio entre la línea y el texto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "${user!.user!.fullName}",style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: sysTextTitle,
                    letterSpacing: -0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${user!.businessSelectModels!.empresa}, -  ${user!.businessSelectModels!.negocio}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: sysTextSubTitle,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    
     // LADO DERECHO: Icono de notificaciones
      actions: [
        IconButton(
          icon: const Icon(Icons.menu, color: AppColors.appBarIcon, size: 30),
          tooltip: 'Go to the next page',
          onPressed: () {
            // Acción para el ícono de notificaciones
          },
        ),
        const SizedBox(width: 3),
      ],
    );
  }
}
