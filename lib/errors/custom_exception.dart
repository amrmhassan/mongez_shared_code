class CustomException implements Exception {
  final String error;
  const CustomException(this.error);
  @override
  String toString() {
    return error;
  }
}
