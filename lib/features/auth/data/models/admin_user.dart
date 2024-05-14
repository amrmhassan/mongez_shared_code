import 'package:json_annotation/json_annotation.dart';
import 'package:mongez_shared_code/features/auth/data/models/user_model.dart';
import 'package:mongez_shared_code/features/auth/data/models/user_type.dart';

part 'admin_user.g.dart';

@JsonSerializable(explicitToJson: true)
class AdminUser extends UserModel {
  AdminUser({
    required super.id,
    required super.name,
    required super.email,
    required super.createdAt,
    super.userType = UserType.admin,
  });
  factory AdminUser.fromJson(Map<String, dynamic> json) =>
      _$AdminUserFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AdminUserToJson(this);
}
