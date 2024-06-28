// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_code_new/shared_code_new/converters/date_time_converter.dart';

import 'package:mongez_shared_code/global/models/location_model.dart';

part 'restaurant_model.g.dart';

@JsonSerializable(explicitToJson: true)
@DateTimeConverter()
class RestaurantModel {
  final String id;
  final String name;
  final LocationModel location;
  final String address;
  final String phone;
  final String managerName;
  final String managerPhoneNumber;
  final String email;
  final String password;
  final String officeId;
  final DateTime createdAt;
  final bool active;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.location,
    required this.address,
    required this.phone,
    required this.managerName,
    required this.managerPhoneNumber,
    required this.email,
    required this.password,
    required this.officeId,
    required this.createdAt,
    required this.active,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
}
