import 'package:hm_flutter_base/core/common/provider/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hm_flutter_base/core/ui/widgets/app_bar_widget.dart';
import 'package:hm_flutter_base/core/ui/widgets/drawer_widget.dart';
import 'dart:ui'; 

class HomeGridScreen extends ConsumerWidget {
    const HomeGridScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuchamos la sesión
    final session = ref.watch(sessionProvider);
    final token = session?.accessToken;
    final user = session?.user;

    final List<Map<String, dynamic>> menuItems = [
      {
        "label": "Riverpod",
        "icon": Icons.airplanemode_active,
        "color": Colors.green,
        "onTap": () => print('Clicked Riverpod'),
      },
      {
        "label": "Formulario 1",
        "icon": Icons.assignment,
        "color": Colors.teal,
        "onTap": () => print('Clicked Formulario 1')
      },
      {
        "label": "Ocupación",
        "icon": Icons.warehouse,
        "color": Colors.indigo,
        "onTap": () => print('Clicked Ocupación')
      },
      {
        "label": "Facturación",
        "icon": Icons.store,
        "color": Colors.pink,
        "onTap": () => print('Clicked Facturación')
      },
      {
        "label": "Recepción Carga",
        "icon": Icons.inventory,
        "color": Colors.brown,
        "onTap": () => print('Clicked Recepción Carga')
      },
      {
        "label": "Racking Salida",
        "icon": Icons.forklift,
        "color": Colors.orange[800],
        "onTap": () =>print('Clicked Racking Salida')
      },
      {
        "label": "Asignación Diques",
        "icon": Icons.local_shipping,
        "color": Colors.orange,
        "onTap": () => print('Clicked Asignación Diques')
      },
      {
        "label": "Ocupación Diques",
        "icon": Icons.view_quilt,
        "color": Colors.cyan,
        "onTap": () => print('Clicked Ocupación Diques')
      },
    ];

    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(),
      body: Stack(
        children: [
          // Fondo de imagen
          
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?q=80&w=2070',
              fit: BoxFit.cover,
            ),
          ),
          // Capa oscura para contraste
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),
          // Grid dinámico
          SafeArea(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: menuItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return _buildGridTile(
                  context,
                  label: item["label"],
                  icon: item["icon"],
                  color: item["color"],
                  onTap: item["onTap"], // Pasamos la función específica
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridTile(BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  child: Icon(icon, color: Colors.white, size: 28),
                ),
                const SizedBox(height: 10),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 3, color: Colors.black)],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}