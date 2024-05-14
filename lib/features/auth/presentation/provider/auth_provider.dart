// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:mongez_shared_code/errors/custom_exception.dart';
import 'package:mongez_shared_code/features/auth/data/datasources/auth_datasource.dart';
import 'package:mongez_shared_code/features/auth/data/datasources/auth_validator.dart';
import 'package:mongez_shared_code/features/auth/data/datasources/password_datasource.dart';
import 'package:mongez_shared_code/features/auth/data/models/user_model.dart';
import 'package:mongez_shared_code/init/runtime_variables.dart';

class AuthProvider extends ChangeNotifier {
  final AuthDatasource _authDatasource = AuthDatasource();
  final AuthValidator _authValidator = AuthValidator();
  // final ProfileDatasource _profileDatasource = ProfileDatasource();
  final PasswordDatasource _passwordDatasource = PasswordDatasource();

  bool loading = false;
  UserModel? loggedUser;

//? this is important to update both ram and locally saved userModel
  // Future<void> _updateLoggedUser(UserModel userModel) async {
  //   loggedUser = userModel;
  //   notifyListeners();
  //   await _authDatasource.updateLocally(userModel);
  // }

  //? errors
  String? nameError;
  String? emailError;
  String? passwordError;
  String? newPasswordError;

  // Future<void> updateProfile({
  //   required String name,
  //   required File? pickedFile,
  //   bool deleteImage = false,
  // }) async {
  //   return _loadingWrapper(() async {
  //     bool doContinue = _nameValidate(name);
  //     if (!doContinue) {
  //       throw CustomException('Please fix your inputs first');
  //     }
  //     if (loggedUser == null) {
  //       throw CustomException('Please login again and try one more time');
  //     }
  //     UserModel userModel = await _profileDatasource.updateProfile(
  //       oldModel: loggedUser!,
  //       name: name,
  //       pickedFile: pickedFile,
  //       deleteImage: deleteImage,
  //     );
  //     await _updateLoggedUser(userModel);
  //   });
  // }

  Future<void> forgetPassword(String email) {
    return _loadingWrapper(() async {
      bool doContinue = _emailValidate(email);
      if (!doContinue) {
        throw CustomException('Please fix your inputs first');
      }

      await firebaseAuth.sendPasswordResetEmail(email: email);
    });
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    return _loadingWrapper(() async {
      if (oldPassword == newPassword) {
        throw CustomException('Please enter a new different password');
      }
      bool doContinue = _passwordValidate(oldPassword, newPassword);
      if (!doContinue) {
        throw CustomException('Please fix your inputs first');
      }
      await _passwordDatasource.changePassword(oldPassword, newPassword);
    });
  }

  Future<UserModel?> loadLoggedUser() async {
    return _loadingWrapper(() async {
      loggedUser = await _authDatasource.getUserById(loggedUser?.id ?? '');
      return loggedUser;
    });
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    return _loadingWrapper(() async {
      bool doContinue = _loginValidate(email, password);
      if (!doContinue) {
        throw CustomException('Please fix your inputs first');
      }
      await _authDatasource.login(email, password);
    });
  }

  bool _loginValidate(String email, String password) {
    emailError = _authValidator.email(email);
    passwordError = _authValidator.password(password);
    notifyListeners();
    return emailError == null && passwordError == null;
  }

  bool _passwordValidate(String oldP, String newP) {
    passwordError = _authValidator.password(oldP);
    newPasswordError = _authValidator.password(newP);
    notifyListeners();
    return passwordError == null && newPasswordError == null;
  }

  bool _emailValidate(String email) {
    emailError = _authValidator.email(email);
    notifyListeners();
    return emailError == null;
  }

  void clearErrors() {
    nameError = null;
    passwordError = null;
    emailError = null;
    notifyListeners();
  }

  Future<void> logout() async {
    return _loadingWrapper(() async {
      await _authDatasource.logout();
    });
  }

  Future<T> _loadingWrapper<T>(Future Function() callback) async {
    try {
      loading = true;
      notifyListeners();

      var res = await callback();

      loading = false;
      notifyListeners();
      return res;
    } catch (e) {
      loading = false;
      notifyListeners();
      rethrow;
    }
  }
}
