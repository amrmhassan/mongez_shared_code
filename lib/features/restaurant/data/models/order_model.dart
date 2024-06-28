// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_code_new/shared_code_new/converters/date_time_converter.dart';

import 'package:mongez_shared_code/features/restaurant/data/models/minified_order.dart';
import 'package:mongez_shared_code/global/models/location_model.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true)
@DateTimeConverter()
class OrderModel {
  final String id;
  final String restaurantId;
  final String officeId;
  final DateTime createdAt;
  final String restaurantPhoneNumber;
  final LocationModel locationModel;
  final String restaurantName;
  final String? customerName;
  final String? customerPhone;
  final LocationModel? customerLocation;
  final String? notes;
  final OrderStatus status;
  final String? assignedTo;

  OrderModel({
    required this.id,
    required this.restaurantId,
    required this.officeId,
    required this.createdAt,
    required this.restaurantPhoneNumber,
    required this.locationModel,
    required this.restaurantName,
    required this.customerName,
    required this.customerPhone,
    required this.customerLocation,
    required this.notes,
    this.status = OrderStatus.pending,
    this.assignedTo,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  MinifiedOrder toMinified() {
    return MinifiedOrder(id: id, createdAt: createdAt);
  }

  OrderModel copyWith({
    String? id,
    String? restaurantId,
    String? officeId,
    DateTime? createdAt,
    String? restaurantPhoneNumber,
    LocationModel? locationModel,
    String? restaurantName,
    String? customerName,
    String? customerPhone,
    LocationModel? customerLocation,
    String? notes,
    OrderStatus? status,
  }) {
    return OrderModel(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      officeId: officeId ?? this.officeId,
      createdAt: createdAt ?? this.createdAt,
      restaurantPhoneNumber:
          restaurantPhoneNumber ?? this.restaurantPhoneNumber,
      locationModel: locationModel ?? this.locationModel,
      restaurantName: restaurantName ?? this.restaurantName,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      customerLocation: customerLocation ?? this.customerLocation,
      notes: notes ?? this.notes,
      status: status ?? this.status,
    );
  }
}

enum OrderStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('assigned')
  assigned,
  @JsonValue('completed')
  completed,
  @JsonValue('uncompleted')
  uncompleted,
}
