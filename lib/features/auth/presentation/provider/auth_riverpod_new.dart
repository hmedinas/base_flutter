import 'package:hm_flutter_base/features/auth/data/models/auth_state.dart';
import 'package:flutter_riverpod/legacy.dart';

final authRiverpodProviderNew = StateProvider.autoDispose<AuthState>((ref) {
  return AuthState(); // Estado inicial
});