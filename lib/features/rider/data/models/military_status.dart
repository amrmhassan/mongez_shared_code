import 'package:json_annotation/json_annotation.dart';

enum MilitaryStatus {
  @JsonValue('fulfilled')
  fulfilled,
  @JsonValue('notFulfilled')
  notFulfilled,
}
