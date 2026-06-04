class ResourceNotFoundException implements Exception {
  final String message;

  ResourceNotFoundException({this.message = 'Recurso não encontrado.'});

  @override
  String toString() => message;
}
