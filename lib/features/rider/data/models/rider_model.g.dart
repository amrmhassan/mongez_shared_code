// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RiderModel _$RiderModelFromJson(Map<String, dynamic> json) => RiderModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      idImageLink: json['idImageLink'] as String,
      maritalStatus: $enumDecode(_$MaritalStatusEnumMap, json['maritalStatus']),
      militaryStatus:
          $enumDecode(_$MilitaryStatusEnumMap, json['militaryStatus']),
      workingModel: $enumDecode(_$WorkingModelEnumMap, json['workingModel']),
      vehicleLicenseLink: json['vehicleLicenseLink'] as String,
      profilePicImageLink: json['profilePicImageLink'] as String,
      officeId: json['officeId'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      createdAt:
          const DateTimeConverter().fromJson(json['createdAt'] as String),
      active: json['active'] as bool,
      birthDate: _$JsonConverterFromJson<String, DateTime>(
          json['birthDate'], const DateTimeConverter().fromJson),
    );

Map<String, dynamic> _$RiderModelToJson(RiderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'idImageLink': instance.idImageLink,
      'maritalStatus': _$MaritalStatusEnumMap[instance.maritalStatus]!,
      'militaryStatus': _$MilitaryStatusEnumMap[instance.militaryStatus]!,
      'workingModel': _$WorkingModelEnumMap[instance.workingModel]!,
      'vehicleLicenseLink': instance.vehicleLicenseLink,
      'profilePicImageLink': instance.profilePicImageLink,
      'officeId': instance.officeId,
      'email': instance.email,
      'password': instance.password,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'active': instance.active,
      'birthDate': _$JsonConverterToJson<String, DateTime>(
          instance.birthDate, const DateTimeConverter().toJson),
    };

const _$MaritalStatusEnumMap = {
  MaritalStatus.single: 'single',
  MaritalStatus.married: 'married',
  MaritalStatus.engaged: 'engaged',
  MaritalStatus.other: 'other',
};

const _$MilitaryStatusEnumMap = {
  MilitaryStatus.fulfilled: 'fulfilled',
  MilitaryStatus.notFulfilled: 'notFulfilled',
};

const _$WorkingModelEnumMap = {
  WorkingModel.partTime: 'partTime',
  WorkingModel.fullTime: 'fullTime',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
