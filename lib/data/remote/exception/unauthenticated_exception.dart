class UnauthenticatedException implements Exception {
  final String msg;
  const UnauthenticatedException([this.msg]);

  @override
  String toString() => 'Unauthenticated: ${msg ?? ''}';
}
