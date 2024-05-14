import 'package:firebase_auth/firebase_auth.dart';
import 'package:localization/localization.dart';
import 'package:mongez_shared_code/errors/custom_exception.dart';
import 'package:mongez_shared_code/errors/firebase_errors.dart';
import 'package:mongez_shared_code/init/runtime_variables.dart';

class PasswordDatasource {
  Future<void> changePassword(String oldPassword, String newPassword) async {
    return fbErrorWrapper(() async {
      var user = firebaseAuth.currentUser;
      if (user == null) {
        throw CustomException('Please login again, user not logged in'.i18n());
      }
      var verifiedUser = await _verifyUserCredentials(user, oldPassword);
      await verifiedUser.updatePassword(newPassword);
    });
  }

  Future<User> _verifyUserCredentials(User user, String oldPassword) async {
    final email = user.email;
    if (email == null) {
      throw CustomException('An error occurred, email is null'.i18n());
    }
    final credential = EmailAuthProvider.credential(
      email: email,
      password: oldPassword,
    );
    var res = await user.reauthenticateWithCredential(credential);
    var newUser = res.user;
    if (newUser == null) {
      throw CustomException('Can\'t verify users credentials'.i18n());
    }
    return newUser;
  }
}
