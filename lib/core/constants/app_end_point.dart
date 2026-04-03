abstract class AppEndPoint {
  // Esta clase queda como un contenedor lógico
  static const login = _Login();
  static const estados = _Estados();
}

class _Login {
  const _Login();
  
  final String login = '/auth/login';

}

class _Estados {
  const _Estados();
  final String allEstados = '/estados/estados';
  final String allRoles = '/estados/roles';
}
