class DatabaseException implements Exception {
  final String message;

  DatabaseException({this.message = 'Database Exception'});

  @override
  String toString() => message;
}
