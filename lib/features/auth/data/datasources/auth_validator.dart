import 'package:shared_code/shared_code.dart';

class AuthValidator {
  String? email(String email) {
    return UserInfoValidation().emailValidation(email);
  }

  String? password(String password) {
    return UserInfoValidation().passwordValidation(password);
  }

  String? name(String name) {
    return UserInfoValidation().firstNameValidation(name);
  }
}
