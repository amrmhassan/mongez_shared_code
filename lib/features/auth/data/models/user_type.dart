import 'package:json_annotation/json_annotation.dart';

enum UserType {
  @JsonValue('admin')
  admin,
  @JsonValue('office')
  office,
  @JsonValue('restaurant')
  restaurant,
  @JsonValue('rider')
  rider,
}
