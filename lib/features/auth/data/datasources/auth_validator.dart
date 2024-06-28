import 'package:shared_code_new/shared_code_new.dart';

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
