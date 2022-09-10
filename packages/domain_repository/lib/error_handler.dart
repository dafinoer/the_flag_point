class DatabaseException implements Exception {
  final String message;

  const DatabaseException(this.message);

  @override
  String toString() {
    return 'DataabaseException: ';
  }
}
