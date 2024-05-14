// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfficeUser _$OfficeUserFromJson(Map<String, dynamic> json) => OfficeUser(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      userType: $enumDecodeNullable(_$UserTypeEnumMap, json['userType']) ??
          UserType.office,
    );

Map<String, dynamic> _$OfficeUserToJson(OfficeUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'createdAt': instance.createdAt.toIso8601String(),
      'userType': _$UserTypeEnumMap[instance.userType]!,
    };

const _$UserTypeEnumMap = {
  UserType.admin: 'admin',
  UserType.office: 'office',
  UserType.restaurant: 'restaurant',
  UserType.rider: 'rider',
};
