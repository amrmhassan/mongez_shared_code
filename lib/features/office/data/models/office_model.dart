// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_code_new/shared_code_new/converters/date_time_converter.dart';

import 'package:mongez_shared_code/global/models/location_model.dart';

part 'office_model.g.dart';

@JsonSerializable(explicitToJson: true)
@DateTimeConverter()
class OfficeModel {
  final String id;
  final String officeName;
  final String managerName;
  final String managerPhoneNumber;
  final LocationModel location;
  final String email;
  final String password;
  final DateTime createdAt;
  final bool active;

  OfficeModel({
    required this.id,
    required this.officeName,
    required this.managerName,
    required this.managerPhoneNumber,
    required this.location,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.active,
  });

  factory OfficeModel.fromJson(Map<String, dynamic> json) =>
      _$OfficeModelFromJson(json);
  Map<String, dynamic> toJson() => _$OfficeModelToJson(this);
}
