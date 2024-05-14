// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RiderUser _$RiderUserFromJson(Map<String, dynamic> json) => RiderUser(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      userType: $enumDecodeNullable(_$UserTypeEnumMap, json['userType']) ??
          UserType.rider,
    );

Map<String, dynamic> _$RiderUserToJson(RiderUser instance) => <String, dynamic>{
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
