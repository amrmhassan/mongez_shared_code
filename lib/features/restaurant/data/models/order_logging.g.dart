// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_logging.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderLogging _$OrderLoggingFromJson(Map<String, dynamic> json) => OrderLogging(
      orderId: json['orderId'] as String,
      action: $enumDecode(_$OrderLoggingActionEnumMap, json['action']),
      loggedAt: DateTime.parse(json['loggedAt'] as String),
    );

Map<String, dynamic> _$OrderLoggingToJson(OrderLogging instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'action': _$OrderLoggingActionEnumMap[instance.action]!,
      'loggedAt': instance.loggedAt.toIso8601String(),
    };

const _$OrderLoggingActionEnumMap = {
  OrderLoggingAction.created: 'created',
  OrderLoggingAction.assigned: 'assigned',
  OrderLoggingAction.failed: 'failed',
  OrderLoggingAction.completed: 'completed',
};
