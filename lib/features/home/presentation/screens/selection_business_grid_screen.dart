import 'package:hm_flutter_base/core/constants/app_contans.dart';
import 'package:hm_flutter_base/core/ui/widgets/business_card_widget.dart';
import 'package:hm_flutter_base/core/ui/widgets/logout_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hm_flutter_base/core/common/provider/session_provider.dart';
// Importa tu modelo de BusinessModels aquí

class SelectionBusinessGridScreen extends ConsumerWidget {
  const SelectionBusinessGridScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Obtenemos la lista de empresas
    final session = ref.watch(sessionProvider);
    final empresas = session?.user?.businessModels ?? [];
    final userName = session?.user?.fullName ?? 'Usuario';

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat ,
      floatingActionButton: const LogoutButtonWidget(),
      // Usamos un fondo con un ligero degradado para que no sea blanco plano
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cabecera de bienvenida llamativa
                Text(
                  "¡Hola, $userName!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Por favor, selecciona tu unidad de negocio para comenzar:",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 32),
                
                // 2. GRID VISUALMENTE ATRACTIVO
                Expanded(
                  child: GridView.builder(
                    // Configuramos el Grid: 2 columnas, espaciado de 16
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 13,
                      mainAxisSpacing: 13,
                      childAspectRatio: 0.85, // Controla la altura de la tarjeta
                    ),
                    itemCount: empresas.length, // ojo importante para saber como recorrer el bucle
                    itemBuilder: (context, index) {
                      final item = empresas[index];
                      // Un helper para decidir el icono según el negocio
                      final IconData businessIcon = _getIconForBusiness(item.negocio);
                      // utilizo un modo grid
                      return BusinessCardWidget (
                        title: item.empresa,
                        subtitle: item.negocio,
                        description: item.desEmpresa,
                        icon: businessIcon, //el icono que pusimoa antes abajp como atajo
                        accentColor: Color.fromARGB(130, 23, 94, 161),
                        onTap: () {
                            ref.read(sessionProvider.notifier).setBusiness(item);
                            Navigator.pushReplacementNamed(context, AppRoutesScreen.homeRadial);
                        },
                        );
                            /*                
                        return _BusinessCard(
                        title: item.empresa.toString(),
                        subtitle: item.negocio,
                        description: item.desEmpresa,
                        icon: businessIcon,
                        onTap: () {
                          // 3. SET: Guardamos la selección
                          ref.read(sessionProvider.notifier).setBusiness(item);
                          // 4. GO: Navegamos al Home
                          Navigator.pushReplacementNamed(context, AppRoutesScreen.homeGrid);
                        },
                      );*/
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      
      ),
    );
  }

  // Helper opcional para dar iconos personalizados según el tipo de negocio
  IconData _getIconForBusiness(String negocio) {
    if (negocio.toLowerCase().contains('importaciones')) return Icons.flight_land_rounded;
    if (negocio.toLowerCase().contains('exportaciones')) return Icons.flight_takeoff_sharp;
    return Icons.business_center; // Icono por defecto
  }
}

// --- WIDGET PERSONALIZADO PARA LA TARJETA (ESTILO VISUAL) ---
class _BusinessCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const _BusinessCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6, // Sombra pronunciada
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      shadowColor: Colors.blue.withOpacity(0.3),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20), // Para el efecto ripple
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // Un sutil degradado interno en la tarjeta
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.blue.shade50.withOpacity(0.5),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icono Grande y Colorido
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 40, color: Colors.blue.shade700),
              ),
              const SizedBox(height: 10),
              // Título de la Empresa
              Flexible(child: 
                Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                )
              ),
              const SizedBox(height: 4),
              // Subtítulo (Negocio)
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade900,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 8),
              // Descripción (Más pequeña)
              Flexible(
                child: Text(
                    description,
                    style: TextStyle(
                    fontSize: 10, // Un poco más pequeña
                    color: Colors.black54,
                    ),
                    maxLines: 1, // Obligado a una sola línea
                    overflow: TextOverflow.ellipsis, // Si no cabe, pone "..."
                    softWrap: false, // Evita que intente buscar espacio abajo
                ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}