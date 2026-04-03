

class AuthState {
  final String userName;
  final String password;
  final bool isLoading;
  final String? errorMessage;

  AuthState({
    this.userName = '',
    this.password = '',
    this.isLoading = false,
    this.errorMessage,
  });

// Método para crear copias del estado cambiando solo lo que necesitemos
  AuthState copyWith({
    String? userName,
    String? password,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}