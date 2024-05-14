class StringUtils {
  String? nullify(String string) {
    if (string.trim().isEmpty) return null;
    return string.trim();
  }
}
