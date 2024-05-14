// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfficeModel _$OfficeModelFromJson(Map<String, dynamic> json) => OfficeModel(
      id: json['id'] as String,
      officeName: json['officeName'] as String,
      managerName: json['managerName'] as String,
      managerPhoneNumber: json['managerPhoneNumber'] as String,
      location:
          LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      email: json['email'] as String,
      password: json['password'] as String,
      createdAt:
          const DateTimeConverter().fromJson(json['createdAt'] as String),
      active: json['active'] as bool,
    );

Map<String, dynamic> _$OfficeModelToJson(OfficeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'officeName': instance.officeName,
      'managerName': instance.managerName,
      'managerPhoneNumber': instance.managerPhoneNumber,
      'location': instance.location.toJson(),
      'email': instance.email,
      'password': instance.password,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'active': instance.active,
    };
