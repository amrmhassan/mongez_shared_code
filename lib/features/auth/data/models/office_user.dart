import 'package:json_annotation/json_annotation.dart';
import 'package:mongez_shared_code/features/auth/data/models/user_model.dart';
import 'package:mongez_shared_code/features/auth/data/models/user_type.dart';

part 'office_user.g.dart';

@JsonSerializable(explicitToJson: true)
class OfficeUser extends UserModel {
  OfficeUser({
    required super.id,
    required super.name,
    required super.email,
    required super.createdAt,
    super.userType = UserType.office,
  });
  factory OfficeUser.fromJson(Map<String, dynamic> json) =>
      _$OfficeUserFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$OfficeUserToJson(this);
}
