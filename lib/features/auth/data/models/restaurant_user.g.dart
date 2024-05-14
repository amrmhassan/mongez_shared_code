// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantUser _$RestaurantUserFromJson(Map<String, dynamic> json) =>
    RestaurantUser(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      userType: $enumDecodeNullable(_$UserTypeEnumMap, json['userType']) ??
          UserType.restaurant,
    );

Map<String, dynamic> _$RestaurantUserToJson(RestaurantUser instance) =>
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
