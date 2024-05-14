import 'package:json_annotation/json_annotation.dart';
import 'package:mongez_shared_code/features/auth/data/models/user_model.dart';
import 'package:mongez_shared_code/features/auth/data/models/user_type.dart';

part 'restaurant_user.g.dart';

@JsonSerializable(explicitToJson: true)
class RestaurantUser extends UserModel {
  RestaurantUser({
    required super.id,
    required super.name,
    required super.email,
    required super.createdAt,
    super.userType = UserType.restaurant,
  });
  factory RestaurantUser.fromJson(Map<String, dynamic> json) =>
      _$RestaurantUserFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RestaurantUserToJson(this);
}
