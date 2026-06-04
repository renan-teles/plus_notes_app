class ResourceAlreadyExistsException implements Exception {
  final String message;

  ResourceAlreadyExistsException({
    this.message = 'Recurso único já existente.',
  });

  @override
  String toString() => message;
}
