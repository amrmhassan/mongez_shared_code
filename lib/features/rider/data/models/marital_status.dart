import 'package:json_annotation/json_annotation.dart';

enum MaritalStatus {
  @JsonValue('single')
  single,
  @JsonValue('married')
  married,
  @JsonValue('engaged')
  engaged,
  @JsonValue('other')
  other,
}
