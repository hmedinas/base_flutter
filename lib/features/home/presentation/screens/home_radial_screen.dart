import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hm_flutter_base/core/common/provider/session_provider.dart';
import 'package:hm_flutter_base/core/constants/app_contans.dart';
import 'package:hm_flutter_base/core/ui/widgets/app_bar_widget.dart';
import 'package:hm_flutter_base/core/ui/widgets/drawer_widget.dart';
import 'package:hm_flutter_base/core/ui/widgets/logout_button_widget.dart';

class HomeRadialScreen extends ConsumerWidget {
  const HomeRadialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     // Escuchamos la sesión
    final session = ref.watch(sessionProvider);
    final token = session?.accessToken;
    final user = session?.user;

    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(),
      
      body: Stack(
        children: [

          // 2. El Menú de Nodos (Centrado)
          Center(
            child: SizedBox(
              width: 350,
              height: 500,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Nodo Central (Foco)
                  NodoMenu(
                    label: "",
                    icon: Icons.more_horiz,
                    backgroundColor: Colors.green,
                    glowColor: Colors.purple,
                    iconColor: Colors.white,
                    textColor: Colors.purple,
                    isCentral: true,
                    onTap: () {
                         Navigator.pushReplacementNamed(context, AppRoutesScreen.selectBusinessGrid);
                    }
                  ),

                  // Nodos Alrededor (Posicionamiento Manual para precisión)
                  // Arriba
                  Positioned(
                    top: 40, 
                    child: NodoMenu(
                        label: "Ubicación", 
                        icon: Icons.location_on, 
                        backgroundColor: Colors.green,
                        glowColor: Colors.purple,
                        iconColor: Colors.white,
                        textColor: Colors.purple,
                        onTap: () {
                           Navigator.pushReplacementNamed(context, AppRoutesScreen.homeBentoBox);
                        }
                    )),
                  
                  // Arriba Diagonales
                  Positioned(top: 100, left: 40, child: NodoMenu(label: "Recepción", icon: Icons.forklift, backgroundColor: Colors.green,
                        glowColor: Colors.purple,
                        iconColor: Colors.white,
                        textColor: Colors.purple,
                        onTap: () {
                         print('Pestaña');
                        }
                    )),
                 Positioned(top: 100, right: 40, child: NodoMenu(label: "Salida", icon: Icons.logout, backgroundColor: Colors.green,
                        glowColor: Colors.purple,
                        iconColor: Colors.white,
                        textColor: Colors.purple,
                        onTap: () {
                         print('Pestaña');
                        }
                    )),

                  // Medio Laterales
                   Positioned(left: 10, child: NodoMenu(label: "Carga", icon: Icons.local_shipping,  backgroundColor: Colors.green,
                        glowColor: Colors.purple,
                        iconColor: Colors.white,
                        textColor: Colors.purple,
                        onTap: () {
                         print('Pestaña');
                        }
                    )),
                   Positioned(right: 10, child: NodoMenu(label: "Conteo", icon: Icons.list_alt,  backgroundColor: Colors.green,
                        glowColor: Colors.purple,
                        iconColor: Colors.white,
                        textColor: Colors.purple,
                        onTap: () {
                         print('Pestaña');
                        }
                    )),

                  // Abajo Diagonales
                   Positioned(bottom: 100, left: 40, child: NodoMenu(label: "Soporte", icon: Icons.info_outline,  backgroundColor: Colors.green,
                        glowColor: Colors.purple,
                        iconColor: Colors.white,
                        textColor: Colors.purple,
                        onTap: () {
                         print('Pestaña');
                        }
                    )),
                   Positioned(bottom: 100, right: 40, child: NodoMenu(label: "Ajustes", icon: Icons.settings,  backgroundColor: Colors.green,
                        glowColor: Colors.purple,
                        iconColor: Colors.white,
                        textColor: Colors.purple,
                        onTap: () {
                         print('Pestaña');
                        }
                    )),

                  // Abajo
                   Positioned(bottom: 40, child: NodoMenu(label: "Perfil", icon: Icons.person,  backgroundColor: Colors.green,
                        glowColor: Colors.purple,
                        iconColor: Colors.white,
                        textColor: Colors.purple,
                        onTap: () {
                         print('Pestaña');
                        }
                    )),
                  
                ],
              ),
            ),
          ),
          
          // 3. Botón Inferior de Acción
          
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child:  NodoMenu(
                    label: "Salir",
                    icon: Icons.logout,
                    backgroundColor: Colors.red,
                    glowColor: Colors.purple,
                    iconColor: Colors.white,
                    textColor: Colors.purple,
                    isCentral: true,
                    onTap: () {

                        ref.read(sessionProvider.notifier).logout(); 
                        Navigator.pushReplacementNamed(context, AppRoutesScreen.splash);
                    }
                  ),

            ),
          ),
          
        ],
      ),
    );
  }
}


class NodoMenu extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor; // fondo del icono
  final Color glowColor;   // Color del resplandor neón
  final Color iconColor;   // Color del icono
  final Color textColor;   // Color del texto
  final String label;
  final VoidCallback onTap; // Función de navegación
  final bool isCentral;
  

  const NodoMenu({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.glowColor,
    required this.iconColor,
    required this.textColor,
    required this.label,
    required this.onTap,
    this.isCentral = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Aquí se activa el click
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
              border: Border.all(color: glowColor.withOpacity(0.5), width: 1),
              boxShadow: [
                BoxShadow(
                  color: glowColor.withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(icon, color: iconColor, size: isCentral ? 35 : 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: textColor, 
              fontSize: 13, 
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}