import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hm_flutter_base/core/common/domain/entities/user_models.dart';
import 'package:hm_flutter_base/core/common/provider/session_provider.dart';
import 'package:hm_flutter_base/core/constants/app_contans.dart';
import 'package:hm_flutter_base/core/utils/text_helpers.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

     final session = ref.watch(sessionProvider);
     if (session?.user == null) return const SizedBox();

    return Drawer(
        child: Column(
          children: [
            SafeArea( // <--- Esto protege tu logo en cualquier móvil
               bottom: false,
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Image(
                        image: AssetImage(AppAssets.logo),
                        height: 40
                    ),
                ),
            ),
            const Divider(color: Colors.green, height: 1),
            _headerDrawer(session!.user!), // Tu función está genial
            const Divider(color: Colors.green, height: 1),

            Expanded(
              child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                      // 2.-  opciones del menu
                      ListTile(
                          leading: const Icon(Icons.home),
                          title: const Text('Radial'),
                          onTap: () =>   Navigator.pushReplacementNamed(context, AppRoutesScreen.homeRadial), // Cierra el drawer
                      ),
                      ListTile(
                          leading: const Icon(Icons.inventory),
                          title: const Text('Bento box'),
                          onTap: () {
                               Navigator.pushReplacementNamed(context, AppRoutesScreen.homeBentoBox);
                          },
                      ),
                       ListTile(
                          leading: const Icon(Icons.category),
                          title: const Text('Categoria'),
                          onTap: () {
                               Navigator.pushReplacementNamed(context, AppRoutesScreen.homeCategori);
                          },
                      ),
                       ListTile(
                          leading: const Icon(Icons.dashboard),
                          title: const Text('Dashboard'),
                          onTap: () {
                               Navigator.pushReplacementNamed(context, AppRoutesScreen.homeDashboard);
                          },
                      ),
                          ListTile(
                          leading: const Icon(Icons.dashboard),
                          title: const Text('Grid'),
                          onTap: () {
                               Navigator.pushReplacementNamed(context, AppRoutesScreen.homeGrid);
                          },
                      ),
                      const Divider(),
                      ListTile(
                          leading: const Icon(Icons.logout, color: Colors.red),
                          title: const Text('Cerrar Sesión'),
                          onTap: () {
                              // Lógica de logout con Riverpod
                          },
                      ),
                  ]
              ),
            ),
          ],
        ),
    );
  }
}

Widget _headerDrawer(UserModels user) {
  return Container(
    color: AppColors.background,
    width: double.infinity,
    padding: const EdgeInsets.all(5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[  
        SizedBox(width: 10),
        Container(
          width: 80,
          height: 80,
          child: Icon(Icons.person_pin_sharp, color: Colors.white, size: 70),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            texto2Lineas(
              'Departamento:',
              '${user.departmentDesc}',
              Colors.white,
              Colors.white,
              13,
              12,
              true,
              false,
            ),
            SizedBox(height: 10),
            texto2Lineas(
              'Usuario:',
              '${user.fullName}',
              Colors.white,
              Colors.white,
              13,
              12,
              true,
              false,
            ),
          ],
        ),
      ],
    ),
  );
}