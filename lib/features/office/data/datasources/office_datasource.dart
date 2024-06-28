// ignore_for_file: prefer_const_constructors, dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:mongez_shared_code/constants/collections.dart';
import 'package:mongez_shared_code/errors/custom_exception.dart';
import 'package:mongez_shared_code/features/auth/data/datasources/auth_datasource.dart';
import 'package:mongez_shared_code/features/auth/data/models/office_user.dart';
import 'package:mongez_shared_code/global/models/location_model.dart';
import 'package:mongez_shared_code/features/office/data/models/office_model.dart';
import 'package:mongez_shared_code/init/runtime_variables.dart';
import 'package:shared_code_new/shared_code_new.dart';

List<OfficeModel> _cache = [];

class OfficeDatasource {
  final AuthDatasource _authDatasource = AuthDatasource();

  //? office CRUD
  Future<OfficeModel> createOffice({
    required String officeName,
    required String managerName,
    required String managerPhoneNumber,
    required String email,
    required String password,
  }) async {
    _validation(
      officeName: officeName,
      managerName: managerName,
      managerPhoneNumber: managerPhoneNumber,
      email: email,
      password: password,
    );
    var user = await _authDatasource.createUser(email, password);
    String id = user.uid;
    OfficeModel officeModel = OfficeModel(
      id: id,
      officeName: officeName,
      managerName: managerName,
      managerPhoneNumber: managerPhoneNumber,
      location: LocationModel(lat: 0, lng: 0),
      email: email,
      password: password,
      createdAt: DateTime.now(),
      active: false,
    );
    await FirebaseFirestore.instance
        .collection(Collections.office)
        .doc(id)
        .set(officeModel.toJson());
    await _createOfficeUser(officeModel: officeModel);
    _addCache(officeModel);
    return officeModel;
  }

  Future<List<OfficeModel>> getAllOffices() async {
    if (_cache.isNotEmpty) {
      _sortCache();
      return _cache;
    }
    var docs =
        (await FirebaseFirestore.instance.collection(Collections.office).get())
            .docs;
    var offices = docs.map((e) => OfficeModel.fromJson(e.data())).toList();
    _cache = [...offices];
    _applyDebuggingFakeOffices();
    _sortCache();
    return _cache;
  }

  Future<void> deleteOffice(String id) async {
    throw CustomException(
        'You need a credit card first to activate firebase admin ');
    await FirebaseFirestore.instance
        .collection(Collections.office)
        .doc(id)
        .delete();
    await _deleteOfficeUser(id);
    _deleteCache(id);
  }

  Future<OfficeModel> updateOffice(
    OfficeModel oldModel, {
    required String officeName,
    required String managerName,
    required String managerPhoneNumber,
  }) async {
    _validation(
      officeName: officeName,
      managerName: managerName,
      managerPhoneNumber: managerPhoneNumber,
      email: oldModel.email,
      password: oldModel.password,
    );
    OfficeModel newModel = OfficeModel(
      id: oldModel.id,
      officeName: officeName,
      managerName: managerName,
      managerPhoneNumber: managerPhoneNumber,
      location: oldModel.location,
      email: oldModel.email,
      password: oldModel.password,
      createdAt: oldModel.createdAt,
      active: oldModel.active,
    );
    await FirebaseFirestore.instance
        .collection(Collections.office)
        .doc(oldModel.id)
        .update(newModel.toJson());
    await _updateOfficeUser(officeModel: newModel);
    _updateCache(newModel);
    return newModel;
  }

  Future<OfficeModel?> getOfficeById(String id) async {
    if (_cache.isEmpty) {
      await getAllOffices();
    }
    int index = _cache.indexWhere((element) => element.id == id);
    if (index == -1) return null;
    return _cache[index];
  }

  //? manage office
  Future<OfficeModel> activateOffice(String id) async {
    throw UnimplementedError();
  }

  Future<OfficeModel> deactivateOffice(String id) async {
    throw UnimplementedError();
  }

//? manage cache
  void _addCache(OfficeModel officeModel) {
    _cache.add(officeModel);
    _sortCache();
  }

  void _updateCache(OfficeModel officeModel) {
    int index = _cache.indexWhere((element) => element.id == officeModel.id);
    if (index == -1) {
      throw CustomException(
          'This office is not present in the cache but it it is updated anyway, just reload the page');
    }
    _cache[index] = officeModel;
    _sortCache();
  }

  void _sortCache() {
    _cache.sort(
      (a, b) => a.createdAt.compareTo(b.createdAt),
    );
  }

  void _deleteCache(String id) {
    _cache.removeWhere((element) => element.id == id);
  }
  //? validation

  void _validation({
    required String officeName,
    required String managerName,
    required String managerPhoneNumber,
    required String email,
    required String password,
  }) {
    if (officeName.length < 3) {
      throw CustomException(
          'Please enter an office name which is longer than 3 letters');
    }
    if (managerName.length < 3) {
      throw CustomException(
          'Please enter a manager name which is longer than 3 letters');
    }
    if (managerPhoneNumber.length < 3) {
      throw CustomException(
          'Please enter a manager phone number which is longer than 3 letters');
    }
    if (email.length < 3) {
      throw CustomException(
          'Please enter a login email which is longer than 3 letters');
    }
    var emailError = UserInfoValidation().emailValidation(email);
    if (emailError != null) {
      throw CustomException(emailError);
    }
    if (password.length < 6) {
      throw CustomException(
          'Please enter a login password which is longer than 6 letters');
    }
  }

  //? debugging
  void _applyDebuggingFakeOffices() {
    return;
    if (!kDebugMode) return;
    List<OfficeModel> fake = [
      OfficeModel(
        id: dartId.generate(),
        officeName: 'Suez Office',
        managerName: 'Amr Hassan',
        managerPhoneNumber: '01147497502',
        location: LocationModel(lat: 0, lng: 0),
        email: 'amr@gmail.com',
        password: '12345678',
        createdAt: DateTime.now(),
        active: true,
      ),
      OfficeModel(
        id: dartId.generate(),
        officeName: 'Banha Office',
        managerName: 'Mohamed Hassan',
        managerPhoneNumber: '01009114571',
        location: LocationModel(lat: 0, lng: 0),
        email: 'mohamed@gmail.com',
        password: '123456789',
        createdAt: DateTime.now(),
        active: true,
      ),
    ];
    _cache.addAll(fake);
    _sortCache();
  }

  //? office user creation
  Future<OfficeUser> _createOfficeUser({
    required OfficeModel officeModel,
  }) async {
    OfficeUser officeUser = OfficeUser(
      id: officeModel.id,
      name: officeModel.managerName,
      email: officeModel.email,
      createdAt: officeModel.createdAt,
    );
    await FirebaseFirestore.instance
        .collection(Collections.users)
        .doc(officeUser.id)
        .set(officeUser.toJson());
    return officeUser;
  }

  Future<OfficeUser> _updateOfficeUser({
    required OfficeModel officeModel,
  }) async {
    OfficeUser officeUser = OfficeUser(
      id: officeModel.id,
      name: officeModel.managerName,
      email: officeModel.email,
      createdAt: officeModel.createdAt,
    );
    await FirebaseFirestore.instance
        .collection(Collections.users)
        .doc(officeUser.id)
        .update(officeUser.toJson());
    return officeUser;
  }

  Future<void> _deleteOfficeUser(String id) async {
    await FirebaseFirestore.instance
        .collection(Collections.users)
        .doc(id)
        .delete();
  }
}
