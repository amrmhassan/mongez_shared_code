// ignore_for_file: prefer_const_constructors, dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mongez_shared_code/constants/collections.dart';
import 'package:mongez_shared_code/errors/custom_exception.dart';
import 'package:mongez_shared_code/features/auth/data/datasources/auth_datasource.dart';
import 'package:mongez_shared_code/features/auth/data/models/restaurant_user.dart';
import 'package:mongez_shared_code/features/office/data/datasources/office_datasource.dart';
import 'package:mongez_shared_code/features/office/data/models/office_model.dart';
import 'package:mongez_shared_code/features/restaurant/data/models/restaurant_model.dart';
import 'package:mongez_shared_code/global/models/location_model.dart';
import 'package:shared_code_new/shared_code_new.dart';

List<RestaurantModel> _cache = [];

class RestaurantDatasource {
  final OfficeDatasource _officeDatasource = OfficeDatasource();
  final AuthDatasource _authDatasource = AuthDatasource();
  //? restaurant CRUD
  Future<RestaurantModel> createRestaurant({
    required String name,
    required String managerName,
    required String managerPhoneNumber,
    required String address,
    required String phone,
    required String officeId,
    required String email,
    required String password,
  }) async {
    officeId = officeId.trim();
    _validation(
      name: name,
      managerName: managerName,
      managerPhoneNumber: managerPhoneNumber,
      email: email,
      password: password,
    );
    var user = await _authDatasource.createUser(email, password);
    String id = user.uid;
    RestaurantModel restaurantModel = RestaurantModel(
      id: id,
      name: name,
      managerName: managerName,
      managerPhoneNumber: managerPhoneNumber,
      location: LocationModel(lat: 0, lng: 0),
      email: email,
      password: password,
      createdAt: DateTime.now(),
      active: false,
      address: address,
      phone: phone,
      officeId: officeId,
    );

    await _validateOfficeId(officeId);
    await FirebaseFirestore.instance
        .collection(Collections.restaurant)
        .doc(id)
        .set(restaurantModel.toJson());
    await _createRestaurantUser(restaurantModel: restaurantModel);
    _addCache(restaurantModel);
    return restaurantModel;
  }

  Future<List<RestaurantModel>> getAllRestaurants() async {
    if (_cache.isNotEmpty) {
      _sortCache();
      return _cache;
    }
    var docs = (await FirebaseFirestore.instance
            .collection(Collections.restaurant)
            .get())
        .docs;
    var restaurants =
        docs.map((e) => RestaurantModel.fromJson(e.data())).toList();
    _cache = [...restaurants];
    _sortCache();
    return _cache;
  }

  Future<void> deleteRestaurant(String id) async {
    throw CustomException(
        'You need a credit card first to activate firebase admin ');
    await FirebaseFirestore.instance
        .collection(Collections.restaurant)
        .doc(id)
        .delete();
    await _deleteRestaurantUser(id);
    _deleteCache(id);
  }

  Future<RestaurantModel> updateRestaurant(
    RestaurantModel oldModel, {
    required String name,
    required String managerName,
    required String managerPhoneNumber,
    required String address,
    required String phone,
    required String officeId,
  }) async {
    officeId = officeId.trim();
    _validation(
      name: name,
      managerName: managerName,
      managerPhoneNumber: managerPhoneNumber,
      email: oldModel.email,
      password: oldModel.password,
    );
    RestaurantModel newModel = RestaurantModel(
      id: oldModel.id,
      name: name,
      managerName: managerName,
      managerPhoneNumber: managerPhoneNumber,
      location: oldModel.location,
      email: oldModel.email,
      password: oldModel.password,
      createdAt: oldModel.createdAt,
      active: oldModel.active,
      address: address,
      phone: phone,
      officeId: officeId,
    );
    await _validateOfficeId(officeId);
    await FirebaseFirestore.instance
        .collection(Collections.restaurant)
        .doc(oldModel.id)
        .update(newModel.toJson());
    await _updateRestaurantUser(restaurantModel: newModel);
    _updateCache(newModel);
    return newModel;
  }

  Future<RestaurantModel?> getUserRestaurant(String userId) async {
    var doc = (await FirebaseFirestore.instance
            .collection(Collections.restaurant)
            .doc(userId)
            .get())
        .data();
    if (doc == null) return null;
    RestaurantModel model = RestaurantModel.fromJson(doc);
    return model;
  }

  //? manage restaurnt
  Future<RestaurantModel> activateRestaurant(String id) async {
    throw UnimplementedError();
  }

  Future<RestaurantModel> deactivateRestaurant(String id) async {
    throw UnimplementedError();
  }

//? manage cache
  void _addCache(RestaurantModel restaurantModel) {
    _cache.add(restaurantModel);
    _sortCache();
  }

  void _updateCache(RestaurantModel restaurantModel) {
    int index =
        _cache.indexWhere((element) => element.id == restaurantModel.id);
    if (index == -1) {
      throw CustomException(
          'This restaurant is not present in the cache but it it is updated anyway, just reload the page');
    }
    _cache[index] = restaurantModel;
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
    required String name,
    required String managerName,
    required String managerPhoneNumber,
    required String email,
    required String password,
  }) {
    if (name.length < 3) {
      throw CustomException(
          'Please enter an restaurant name which is longer than 3 letters');
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

  Future<OfficeModel> _validateOfficeId(String officeId) async {
    var restaurantModel = await _officeDatasource.getOfficeById(officeId);
    if (restaurantModel == null) {
      throw CustomException(
          'This office id doesn\'t represent any office at all, please get the right office id');
    }
    return restaurantModel;
  }

  //? restaurant user creation
  Future<RestaurantUser> _createRestaurantUser({
    required RestaurantModel restaurantModel,
  }) async {
    RestaurantUser restaurantUser = RestaurantUser(
      id: restaurantModel.id,
      name: restaurantModel.managerName,
      email: restaurantModel.email,
      createdAt: restaurantModel.createdAt,
    );
    await FirebaseFirestore.instance
        .collection(Collections.users)
        .doc(restaurantUser.id)
        .set(restaurantUser.toJson());
    return restaurantUser;
  }

  Future<RestaurantUser> _updateRestaurantUser({
    required RestaurantModel restaurantModel,
  }) async {
    RestaurantUser restaurantUser = RestaurantUser(
      id: restaurantModel.id,
      name: restaurantModel.managerName,
      email: restaurantModel.email,
      createdAt: restaurantModel.createdAt,
    );
    await FirebaseFirestore.instance
        .collection(Collections.users)
        .doc(restaurantUser.id)
        .update(restaurantUser.toJson());
    return restaurantUser;
  }

  Future<void> _deleteRestaurantUser(String id) async {
    await FirebaseFirestore.instance
        .collection(Collections.users)
        .doc(id)
        .delete();
  }
}
