import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hm_flutter_base/core/common/provider/session_provider.dart';
import 'package:hm_flutter_base/core/ui/widgets/app_bar_widget.dart';
import 'package:hm_flutter_base/core/ui/widgets/drawer_widget.dart';

class HomeBentoBoxScreen  extends ConsumerWidget {
  const HomeBentoBoxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     // Escuchamos la sesión
    final session = ref.watch(sessionProvider);
    final token = session?.accessToken;
    final user = session?.user;

    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(),
      // El ScrollView permite que la pantalla crezca hacia abajo
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
        child: Column(
          children: [
            // 1. ÍTEM PRINCIPAL (ANCHO COMPLETO)
            _buildBentoCard(
              context,
              height: 180,
              color: const Color(0xFF1E88E5), 
              icon: Icons.forklift,
              title: "RECEPCIÓN CARGA",
              subtitle: "(12 camiones)",
              isDark: true,
              onTap: () => print("Ir a Recepción"),
            ),
            const SizedBox(height: 15),

            // 2. FILA ASIMÉTRICA (60% / 40%)
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _buildBentoCard(
                    context,
                    height: 160,
                    color: const Color(0xFF4DB6AC),
                    icon: Icons.shelves,
                    title: "RACKING SALIDA",
                    subtitle: "OUTGOING RACKING",
                    isDark: true,
                    onTap: () => print("Ir a Racking"),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 2,
                  child: _buildBentoCard(
                    context,
                    height: 160,
                    color: const Color(0xFFFFD54F),
                    icon: Icons.warehouse,
                    title: "OCUPACIÓN\nDIQUES",
                    isDark: false,
                    onTap: () => print("Ir a Diques"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // 3. FILA SIMÉTRICA (50% / 50%)
            Row(
              children: [
                Expanded(
                  child: _buildBentoCard(
                    context,
                    height: 140,
                    color: Colors.white,
                    icon: Icons.description,
                    iconColor: Colors.blue,
                    title: "FACTURACIÓN",
                    subtitle: "INVOICING",
                    isDark: false,
                    onTap: () => print("Ir a Facturación"),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildBentoCard(
                    context,
                    height: 140,
                    color: Colors.white,
                    icon: Icons.inventory_2,
                    iconColor: Colors.green,
                    title: "INVENTARIO",
                    subtitle: "INVENTARIO",
                    isDark: false,
                    onTap: () => print("Ir a Inventario"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

           // 4. FILA SIMÉTRICA (50% / 50%)
            Row(
              children: [
                Expanded(
                  child: _buildSmallCard(
                    context,
                    label: "MALIFE",
                    icon: Icons.campaign,
                    color: Colors.yellow[100]!,
                    onTap: () => print("Redirect a Malife"),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildSmallCard(
                    context,
                    label: "RCFIC",
                    icon: Icons.storefront,
                    color: Colors.red[50]!,
                    onTap: () => print("Redirect a RCFIC"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // 4. MÁS TARJETAS PARA PROBAR EL SCROLL
            _buildBentoCard(
              context,
              height: 120,
              color: Colors.white,
              icon: Icons.history,
              iconColor: Colors.grey,
              title: "HISTORIAL RECIENTE",
              isDark: false,
              onTap: () => print("Ir al Historial"),
            ),
            const SizedBox(height: 100), // Espacio extra al final para notar el scroll

          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER ACTUALIZADO CON REDIRECT ---
  Widget _buildBentoCard(
    BuildContext context, {
    required double height,
    required Color color,
    required IconData icon,
    required String title,
    String? subtitle,
    required bool isDark,
    required VoidCallback onTap, // Parámetro para el redirect
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap, // Se activa al tocar la tarjeta
      child: Container(
        width: double.infinity, // Esto asegura que ocupe todo el ancho si no está en un Row
        height: height,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 42, color: isDark ? Colors.white : (iconColor ?? Colors.black87)),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black45,
                  fontSize: 11,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

 // --- WIDGET 2: TARJETA COMPACTA (Small Card) ---
  Widget _buildSmallCard(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: Colors.black54),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

}