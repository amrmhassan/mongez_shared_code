extension DateExtension on DateTime {
  bool equal(DateTime? other) {
    if (other == null) return false;
    return year == other.year && month == other.month && day == other.day;
  }
}
