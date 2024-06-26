// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_code/shared_code/converters/date_time_converter.dart';

part 'minified_order.g.dart';

@JsonSerializable(explicitToJson: true)
@DateTimeConverter()
class MinifiedOrder {
  final String id;
  final DateTime createdAt;
  MinifiedOrder({
    required this.id,
    required this.createdAt,
  });

  factory MinifiedOrder.fromJson(Map<String, dynamic> json) =>
      _$MinifiedOrderFromJson(json);
  Map<String, dynamic> toJson() => _$MinifiedOrderToJson(this);
}
