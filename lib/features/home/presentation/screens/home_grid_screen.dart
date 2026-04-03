import 'package:base_flutter/core/common/provider/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeGridScreen extends ConsumerWidget {
    const HomeGridScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuchamos la sesión
    final session = ref.watch(sessionProvider);
    final token = session?.accessToken;
    final user = session?.user;

    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido, ${user?.fullName ?? 'Usuario'}"),
      ),
      body: Center(
        child: Text("Tu cargo es: ${user?.title}"),
      ),
    );
  }
}