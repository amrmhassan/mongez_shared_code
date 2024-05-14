import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mongez_shared_code/errors/custom_exception.dart';

Future<T> fbErrorWrapper<T>(Future<T> Function() callback) async {
  try {
    var res = await callback();
    return res;
  } on FirebaseAuthException catch (e) {
    String message = e.message ?? e.code;
    if (e.code == 'channel-error') {
      message = 'Please check your inputs';
    } else if (e.code == 'invalid-email') {
      message = 'The email address is badly formatted';
    } else if (e.code == 'weak-password') {
      message = 'Password should be at lease 6 characters';
    } else if (e.code == 'user-not-found') {
      message = 'No user registered with this email';
    } else if (e.code == 'wrong-password') {
      message = 'This password is wrong, Please double check it';
    } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
      message = 'Invalid Login Credentials';
    }
    throw CustomException(message);
  } catch (e) {
    rethrow;
  }
}
