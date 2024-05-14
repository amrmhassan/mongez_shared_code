// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantModel _$RestaurantModelFromJson(Map<String, dynamic> json) =>
    RestaurantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location:
          LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      address: json['address'] as String,
      phone: json['phone'] as String,
      managerName: json['managerName'] as String,
      managerPhoneNumber: json['managerPhoneNumber'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      officeId: json['officeId'] as String,
      createdAt:
          const DateTimeConverter().fromJson(json['createdAt'] as String),
      active: json['active'] as bool,
    );

Map<String, dynamic> _$RestaurantModelToJson(RestaurantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location.toJson(),
      'address': instance.address,
      'phone': instance.phone,
      'managerName': instance.managerName,
      'managerPhoneNumber': instance.managerPhoneNumber,
      'email': instance.email,
      'password': instance.password,
      'officeId': instance.officeId,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'active': instance.active,
    };
