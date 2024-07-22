// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as String,
      restaurantId: json['restaurantId'] as String,
      officeId: json['officeId'] as String,
      createdAt:
          const DateTimeConverter().fromJson(json['createdAt'] as String),
      restaurantPhoneNumber: json['restaurantPhoneNumber'] as String,
      locationModel:
          LocationModel.fromJson(json['locationModel'] as Map<String, dynamic>),
      restaurantName: json['restaurantName'] as String,
      customerName: json['customerName'] as String?,
      customerPhone: json['customerPhone'] as String?,
      customerLocation: json['customerLocation'] == null
          ? null
          : LocationModel.fromJson(
              json['customerLocation'] as Map<String, dynamic>),
      notes: json['notes'] as String?,
      status: $enumDecode(_$OrderStatusEnumMap, json['status']),
      assignedTo: json['assignedTo'] as String?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restaurantId': instance.restaurantId,
      'officeId': instance.officeId,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'restaurantPhoneNumber': instance.restaurantPhoneNumber,
      'locationModel': instance.locationModel.toJson(),
      'restaurantName': instance.restaurantName,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'customerLocation': instance.customerLocation?.toJson(),
      'notes': instance.notes,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'assignedTo': instance.assignedTo,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.assigned: 'assigned',
  OrderStatus.completed: 'completed',
  OrderStatus.uncompleted: 'uncompleted',
};
