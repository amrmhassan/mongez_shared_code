// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:mongez_shared_code/features/restaurant/data/datasources/logging_datasource.dart';

part 'order_logging.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderLogging {
  final String orderId;
  final OrderLoggingAction action;
  final DateTime loggedAt;
  OrderLogging({
    required this.orderId,
    required this.action,
    required this.loggedAt,
  });

  factory OrderLogging.fromJson(Map<String, dynamic> json) =>
      _$OrderLoggingFromJson(json);
  Map<String, dynamic> toJson() => _$OrderLoggingToJson(this);
}

enum OrderLoggingAction {
  @JsonValue('created')
  created,
  @JsonValue('assigned')
  assigned,
  @JsonValue('failed')
  failed,
  @JsonValue('completed')
  completed,
}
