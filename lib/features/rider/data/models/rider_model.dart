// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_code/shared_code/converters/date_time_converter.dart';

import 'package:mongez_shared_code/features/rider/data/models/marital_status.dart';
import 'package:mongez_shared_code/features/rider/data/models/military_status.dart';
import 'package:mongez_shared_code/features/rider/data/models/working_model.dart';

part 'rider_model.g.dart';

@JsonSerializable(explicitToJson: true)
@DateTimeConverter()
class RiderModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String idImageLink;
  final MaritalStatus? maritalStatus;
  final MilitaryStatus? militaryStatus;
  final WorkingModel? workingModel;
  final String vehicleLicenseLink;
  final String profilePicImageLink;
  final String officeId;
  final String email;
  final String password;
  final DateTime createdAt;
  final bool active;
  final DateTime? birthDate;

  RiderModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.idImageLink,
    required this.maritalStatus,
    required this.militaryStatus,
    required this.workingModel,
    required this.vehicleLicenseLink,
    required this.profilePicImageLink,
    required this.officeId,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.active,
    required this.birthDate,
  });

  factory RiderModel.fromJson(Map<String, dynamic> json) =>
      _$RiderModelFromJson(json);
  Map<String, dynamic> toJson() => _$RiderModelToJson(this);
}
