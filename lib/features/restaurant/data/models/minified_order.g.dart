// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minified_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinifiedOrder _$MinifiedOrderFromJson(Map<String, dynamic> json) =>
    MinifiedOrder(
      id: json['id'] as String,
      createdAt:
          const DateTimeConverter().fromJson(json['createdAt'] as String),
    );

Map<String, dynamic> _$MinifiedOrderToJson(MinifiedOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
    };
