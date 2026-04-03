/*
    esto es importante para menejar riverpod
*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:base_flutter/features/auth/data/models/auth_state.dart';
import 'package:base_flutter/features/auth/data/sources/auth_api.dart';
import 'package:base_flutter/features/auth/data/models/login_response_model.dart';
import 'package:flutter_riverpod/legacy.dart';

// Definimos el provider de forma global
final authRiverpodProvider = StateNotifierProvider.autoDispose<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(AuthApi());
});

class AuthNotifier extends StateNotifier<AuthState> {
    final AuthApi _authService;

    AuthNotifier(this._authService) : super(AuthState());

    void setUserName(String value) => state = state.copyWith(userName: value, errorMessage: null);
    void setPassword(String value) => state = state.copyWith(password: value, errorMessage: null);

    bool isValidForm() {
        return state.userName.trim().length >= 3 && state.password.trim().length >= 3;
    }

    Future<LoginResponseModel?> login() async 
    {
        state = state.copyWith(isLoading: true, errorMessage: null);

        try {
        final response = await _authService.login(state.userName, state.password);
        state = state.copyWith(isLoading: false);
        return response;
        } catch (e) {
        state = state.copyWith(isLoading: false, errorMessage: "Error de red");
        return null;
        }
    }
 }