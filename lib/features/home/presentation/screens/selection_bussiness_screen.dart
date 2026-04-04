import 'package:hm_flutter_base/core/constants/app_contans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hm_flutter_base/core/common/provider/session_provider.dart';

class SelectionBusinessScreen extends ConsumerWidget {
  const SelectionBusinessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Obtenemos la lista de empresas del usuario logueado
    final session = ref.watch(sessionProvider);
    final empresas = session?.user?.businessModels ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Seleccione Empresa"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Bienvenido, selecciona una unidad de negocio para continuar:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            
            // 2. Listamos las empresas con iconos
            Expanded(
              child: ListView.builder(
                itemCount: empresas.length,
                itemBuilder: (context, index) {
                  final item = empresas[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.business, color: Colors.white),
                      ),
                      title: Text(item.empresa.toString(), 
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("${item.negocio} - ${item.desEmpresa}"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // 3. SET: Guardamos la empresa seleccionada en el Store
                        ref.read(sessionProvider.notifier).setBusiness(item);
                        
                        // 4. GO: Navegamos al Home
                        Navigator.pushReplacementNamed(context, AppRoutesScreen.homeGrid);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}