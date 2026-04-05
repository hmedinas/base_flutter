import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hm_flutter_base/core/common/provider/session_provider.dart';
import 'package:hm_flutter_base/core/ui/widgets/app_bar_widget.dart';
import 'package:hm_flutter_base/core/ui/widgets/drawer_widget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class HomeDashboardScreen extends ConsumerWidget {
  const HomeDashboardScreen({super.key});

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
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 15, left: 5),
              child: Text(
                "ESTADO DEL ALMACÉN",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),

            // --- TARJETA CON EL GAUGE REAL ---
            _buildOcupacionGaugeCard(87),
            const SizedBox(height: 15),

            // --- GRID DE TARJETAS (REUTILIZANDO EL ANTERIOR) ---
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.85,
              children: [
                _buildDashboardCard("RECEP. CARGA", Icons.local_shipping, Colors.blue, "3", "Camiones\nen espera"),
                _buildDashboardCard("RACKING SALIDA", Icons.shelves, Colors.green, "12", "Órdenes\npara hoy"),
                _buildDashboardCard("ASIG. DIQUES", Icons.bus_alert, Colors.orange, "A-4", "Dique A-4\nActivo", valueColor: Colors.green),
                _buildDashboardCard("FACTURACIÓN", Icons.receipt_long, Colors.purple, "15", "Docs.\nPendientes"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- EL WIDGET DEL GAUGE (SEMICÍRCULO) ---
  Widget _buildOcupacionGaugeCard(double value) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Lado Izquierdo: El Gráfico
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 120,
              child: SfRadialGauge (
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    startAngle: 180,
                    endAngle: 0,
                    showLabels: false,
                    showTicks: false,
                    radiusFactor: 1,
                    axisLineStyle: AxisLineStyle(
                      thickness: 0.2,
                      color: Colors.blue.withOpacity(0.1),
                      thicknessUnit: GaugeSizeUnit.factor,
                    ),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: value,
                        width: 0.2,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: const Color(0xFF5B9BD5), // El azul de tu imagen
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                      MarkerPointer(
                        value: value,
                        markerType: MarkerType.circle,
                        color: Colors.grey[700],
                        markerHeight: 10,
                        markerWidth: 10,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          // Lado Derecho: Los Textos
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text("Ocupación Total:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                Text(
                  "${value.toInt()}%",
                  style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // (Mantenemos el _buildDashboardCard del paso anterior)
  Widget _buildDashboardCard(String title, IconData icon, Color color, String val, String desc, {Color valueColor = Colors.black}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Align(alignment: Alignment.centerLeft, child: Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54))),
          const Spacer(),
          CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color)),
          const Spacer(),
          Text(val, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: valueColor)),
          Text(desc, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: Colors.black87)),
        ],
      ),
    );
  }
}

