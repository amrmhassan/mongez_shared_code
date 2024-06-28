// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_code_new/shared_code_new/converters/date_time_converter.dart';

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
  final RiderStatus status;

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
    this.status = RiderStatus.free,
  });

  factory RiderModel.fromJson(Map<String, dynamic> json) =>
      _$RiderModelFromJson(json);
  Map<String, dynamic> toJson() => _$RiderModelToJson(this);

  RiderModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? idImageLink,
    MaritalStatus? maritalStatus,
    MilitaryStatus? militaryStatus,
    WorkingModel? workingModel,
    String? vehicleLicenseLink,
    String? profilePicImageLink,
    String? officeId,
    String? email,
    String? password,
    DateTime? createdAt,
    bool? active,
    DateTime? birthDate,
    RiderStatus? status,
  }) {
    return RiderModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      idImageLink: idImageLink ?? this.idImageLink,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      militaryStatus: militaryStatus ?? this.militaryStatus,
      workingModel: workingModel ?? this.workingModel,
      vehicleLicenseLink: vehicleLicenseLink ?? this.vehicleLicenseLink,
      profilePicImageLink: profilePicImageLink ?? this.profilePicImageLink,
      officeId: officeId ?? this.officeId,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      active: active ?? this.active,
      birthDate: birthDate ?? this.birthDate,
      status: status ?? this.status,
    );
  }
}

enum RiderStatus {
  free,
  assigned,
}
