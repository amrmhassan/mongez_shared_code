// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mongez_shared_code/constants/shared_pref_constants.dart';
import 'package:mongez_shared_code/constants/collections.dart';
import 'package:mongez_shared_code/errors/custom_exception.dart';
import 'package:mongez_shared_code/features/auth/data/models/user_model.dart';
import 'package:mongez_shared_code/helpers/shared_pref_helper.dart';
import 'package:mongez_shared_code/init/runtime_variables.dart';

List<UserModel> _users = [];

class AuthDatasource {
  Future<UserModel?> getLoggedInUser() async {
    await firebaseAuth.currentUser?.reload();
    String? userId = firebaseAuth.currentUser?.uid;
    if (userId == null) return null;
    var remote = await getUserById(userId);
    if (remote != null) {
      await saveLocally(remote);
      return remote;
    }
    return null;
  }

  Future<UserModel?> getUserById(String id) async {
    var cached = _fromCache(id);
    if (cached != null) return cached;
    var doc = (await FirebaseFirestore.instance
            .collection(Collections.users)
            .doc(id)
            .get())
        .data();
    if (doc == null) return null;
    var model = UserModel.fromJson(doc);
    _updateUserCache(model);

    return model;
  }

  Future<Map<String, dynamic>?> getUserDataById(String id) async {
    var doc = (await FirebaseFirestore.instance
            .collection(Collections.users)
            .doc(id)
            .get())
        .data();
    if (doc == null) return null;
    return doc;
  }

  UserModel? _fromCache(String id) {
    int index = _users.indexWhere((element) => element.id == id);
    if (index == -1) {
      return null;
    } else {
      return _users[index];
    }
  }

  void _updateUserCache(UserModel userModel) {
    int index = _users.indexWhere((element) => element.id == userModel.id);
    if (index == -1) {
      _users.add(userModel);
    } else {
      _users[index] = userModel;
    }
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
    await _deleteLocally();
  }

  Future<void> saveLocally(UserModel userModel) async {
    String value = json.encode(userModel.toJson());
    await SharedPrefHelper.setString(SharedPrefKeys.loggedUser, value);
  }

  Future<void> _deleteLocally() async {
    await SharedPrefHelper.removeKey(SharedPrefKeys.loggedUser);
  }

  Future<void> updateLocally(UserModel userModel) async {
    return saveLocally(userModel);
  }

  //? auth part
  Future<User> createUser(String email, String password) async {
    var cred = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    var user = cred.user;
    if (user == null) {
      throw CustomException('Sorry, Can\'t create this user');
    }
    return user;
  }
}
