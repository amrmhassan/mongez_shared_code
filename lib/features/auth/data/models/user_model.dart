import 'package:json_annotation/json_annotation.dart';
import 'package:mongez_shared_code/features/auth/data/models/admin_user.dart';
import 'package:mongez_shared_code/features/auth/data/models/office_user.dart';
import 'package:mongez_shared_code/features/auth/data/models/restaurant_user.dart';
import 'package:mongez_shared_code/features/auth/data/models/rider_user.dart';
import 'package:mongez_shared_code/features/auth/data/models/user_type.dart';
import 'package:shared_code_new/shared_code_new/converters/date_time_converter.dart';
part 'user_model.g.dart';

@JsonSerializable()
@DateTimeConverter()
class UserModel {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;
  final UserType userType;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static UserModel fromData(Map<String, dynamic> data) {
    UserModel userModel = UserModel.fromJson(data);
    UserType userType = userModel.userType;
    if (userType == UserType.admin) {
      return AdminUser.fromJson(data);
    }
    if (userType == UserType.office) {
      return OfficeUser.fromJson(data);
    }
    if (userType == UserType.restaurant) {
      return RestaurantUser.fromJson(data);
    }
    if (userType == UserType.rider) {
      return RiderUser.fromJson(data);
    }
    throw UnimplementedError();
  }
}
