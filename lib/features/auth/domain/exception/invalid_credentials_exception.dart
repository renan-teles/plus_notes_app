class InvalidCredentialsException implements Exception {
  final String message;

  InvalidCredentialsException({this.message = 'Credenciais inválidas.'});

  @override
  String toString() => message;
}
