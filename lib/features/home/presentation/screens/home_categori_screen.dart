import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hm_flutter_base/core/common/provider/session_provider.dart';
import 'package:hm_flutter_base/core/ui/widgets/app_bar_widget.dart';
import 'package:hm_flutter_base/core/ui/widgets/drawer_widget.dart';

class HomeCategoriScreen extends ConsumerWidget {
  const HomeCategoriScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     // Escuchamos la sesión
    final session = ref.watch(sessionProvider);
    final token = session?.accessToken;
    final user = session?.user;

    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(),
     body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            // --- SECCIÓN OPERACIONES ---
            _buildSectionTitle("OPERACIONES", Colors.blue[700]!),
            _buildGridMenu(context, [
              _MenuData("Recepción", Icons.inventory_2, Colors.blue[50]!, () => print("Rec")),
              _MenuData("Despacho", Icons.local_shipping, Colors.orange[50]!, () => print("Des")),
              _MenuData("Ubicación", Icons.forklift, Colors.purple[50]!, () => print("Ubi")),
              _MenuData("Conteo Cíclico", Icons.checklist_rtl, Colors.pink[50]!, () => print("Cont")),
            ]),

            const SizedBox(height: 30),

            // --- SECCIÓN ADMINISTRACIÓN ---
            _buildSectionTitle("ADMINISTRACIÓN", Colors.green[700]!),
            _buildGridMenu(context, [
              _MenuData("Facturación", Icons.receipt_long, Colors.teal[50]!, () => print("Fact")),
              _MenuData("Inventario", Icons.grid_view, Colors.green[50]!, () => print("Inv")),
            ]),
          ],
        ),
      ),
    );
  }

  // Título de la categoría
  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 5),
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  // Grid que contiene las tarjetas
  Widget _buildGridMenu(BuildContext context, List<_MenuData> items) {
    return GridView.builder(
      shrinkWrap: true, // Importante: permite que el Grid esté dentro del ScrollView
      physics: const NeverScrollableScrollPhysics(), // El scroll lo maneja el padre
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 columnas
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1.0, // Tarjetas cuadradas
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildMenuCard(item);
      },
    );
  }

  // La tarjeta individual (Caja blanca con borde y sombra sutil)
  Widget _buildMenuCard(_MenuData item) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Círculo de color sutil detrás del icono
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: item.bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(item.icon, size: 35, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Text(
              item.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Clase de apoyo para los datos del menú
class _MenuData {
  final String title;
  final IconData icon;
  final Color bgColor;
  final VoidCallback onTap;

  _MenuData(this.title, this.icon, this.bgColor, this.onTap);
}