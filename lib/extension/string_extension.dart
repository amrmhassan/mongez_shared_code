import 'package:mongez_shared_code/utils/string_utils.dart';

extension StringExtensions on String {
  String? get nullify {
    return StringUtils().nullify(this);
  }
}
