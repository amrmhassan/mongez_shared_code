import 'package:json_annotation/json_annotation.dart';
import 'package:mongez_shared_code/features/auth/data/models/user_model.dart';
import 'package:mongez_shared_code/features/auth/data/models/user_type.dart';

part 'rider_user.g.dart';

@JsonSerializable(explicitToJson: true)
class RiderUser extends UserModel {
  RiderUser({
    required super.id,
    required super.name,
    required super.email,
    required super.createdAt,
    super.userType = UserType.rider,
  });
  factory RiderUser.fromJson(Map<String, dynamic> json) =>
      _$RiderUserFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RiderUserToJson(this);
}
