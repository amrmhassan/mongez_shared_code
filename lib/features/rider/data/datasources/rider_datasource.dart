// ignore_for_file: prefer_const_constructors, dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mongez_shared_code/constants/collections.dart';
import 'package:mongez_shared_code/constants/remote_storage.dart';
import 'package:mongez_shared_code/errors/custom_exception.dart';
import 'package:mongez_shared_code/features/auth/data/datasources/auth_datasource.dart';
import 'package:mongez_shared_code/features/auth/data/models/rider_user.dart';
import 'package:mongez_shared_code/global/datasource/web_storage_datasource.dart';
import 'package:mongez_shared_code/features/rider/data/models/marital_status.dart';
import 'package:mongez_shared_code/features/rider/data/models/military_status.dart';
import 'package:mongez_shared_code/features/rider/data/models/rider_model.dart';
import 'package:mongez_shared_code/features/rider/data/models/working_model.dart';
import 'package:shared_code_new/shared_code_new.dart';

List<RiderModel> _cache = [];

class RiderDatasource {
  final WebStorageDatasource _storageDatasource = WebStorageDatasource();
  final AuthDatasource _authDatasource = AuthDatasource();

  //? rider CRUD
  Future<RiderModel> createRider({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String officeId,
    required XFile? vehicleLicense,
    required XFile? riderIdImage,
    required XFile? profilePicImage,
    required WorkingModel? workingModel,
    required MaritalStatus? maritalStatus,
    required MilitaryStatus? militaryStatus,
    required DateTime? birthDate,
  }) async {
    _validation(
      name: name,
      phoneNumber: phone,
      email: email,
      password: password,
    );
    var user = await _authDatasource.createUser(email, password);
    String id = user.uid;
    String idImageLink = await _riderIdImage(riderIdImage, id);
    String vehicleLicenseLink =
        await _riderVehicleLicenseImage(vehicleLicense, id);
    String profilePicImageLink = await _riderProfileImage(profilePicImage, id);

    RiderModel riderModel = RiderModel(
      id: id,
      name: name,
      phoneNumber: phone,
      idImageLink: idImageLink,
      maritalStatus: maritalStatus,
      militaryStatus: militaryStatus,
      workingModel: workingModel,
      vehicleLicenseLink: vehicleLicenseLink,
      profilePicImageLink: profilePicImageLink,
      officeId: officeId,
      email: email,
      password: password,
      createdAt: DateTime.now(),
      active: false,
      birthDate: birthDate,
    );
    await FirebaseFirestore.instance
        .collection(Collections.rider)
        .doc(id)
        .set(riderModel.toJson());
    await _createRiderUser(riderModel: riderModel);
    _addCache(riderModel);
    return riderModel;
  }

  Future<List<RiderModel>> getAllRiders() async {
    if (_cache.isNotEmpty) {
      _sortCache();
      return _cache;
    }
    var docs =
        (await FirebaseFirestore.instance.collection(Collections.rider).get())
            .docs;
    var riders = docs.map((e) => RiderModel.fromJson(e.data())).toList();
    _cache = [...riders];
    _sortCache();
    return _cache;
  }

  Future<void> deleteRider(String id) async {
    throw CustomException(
        'You need a credit card first to activate firebase admin ');
    await FirebaseFirestore.instance
        .collection(Collections.rider)
        .doc(id)
        .delete();
    await _deleteRiderUser(id);
    _deleteCache(id);
  }

  Future<RiderModel> updateRider(
    RiderModel oldModel, {
    required String name,
    required String phone,
    required String email,
    required String password,
    required String officeId,
    required XFile? vehicleLicense,
    required XFile? riderIdImage,
    required XFile? profilePicImage,
    required WorkingModel workingModel,
    required MaritalStatus maritalStatus,
    required int age,
    required MilitaryStatus militaryStatus,
    required DateTime? birthDate,
  }) async {
    _validation(
      name: name,
      phoneNumber: phone,
      email: oldModel.email,
      password: oldModel.password,
    );
    String idImageLink = await _riderIdImageUpdate(
        riderIdImage, oldModel.id, oldModel.idImageLink);
    String vehicleLicenseLink = await _riderIdImageUpdate(
        vehicleLicense, oldModel.id, oldModel.vehicleLicenseLink);
    String profilePicImageLink = await _riderIdImageUpdate(
        profilePicImage, oldModel.id, oldModel.profilePicImageLink);

    RiderModel newModel = RiderModel(
      id: oldModel.id,
      name: name,
      phoneNumber: phone,
      idImageLink: idImageLink,
      maritalStatus: maritalStatus,
      militaryStatus: militaryStatus,
      workingModel: workingModel,
      vehicleLicenseLink: vehicleLicenseLink,
      profilePicImageLink: profilePicImageLink,
      officeId: officeId,
      email: email,
      password: password,
      createdAt: oldModel.createdAt,
      active: oldModel.active,
      birthDate: birthDate,
    );
    await FirebaseFirestore.instance
        .collection(Collections.rider)
        .doc(oldModel.id)
        .update(newModel.toJson());
    await _updateRiderUser(riderModel: newModel);
    _updateCache(newModel);
    return newModel;
  }

  Future<RiderModel?> getRiderById(String id) async {
    if (_cache.isEmpty) {
      await getAllRiders();
    }
    int index = _cache.indexWhere((element) => element.id == id);
    if (index == -1) return null;
    return _cache[index];
  }

  //? manage rider
  Future<RiderModel> activateRider(String id) async {
    throw UnimplementedError();
  }

  Future<RiderModel> deactivateRider(String id) async {
    throw UnimplementedError();
  }

//? manage cache
  void _addCache(RiderModel riderModel) {
    _cache.add(riderModel);
    _sortCache();
  }

  void _updateCache(RiderModel riderModel) {
    int index = _cache.indexWhere((element) => element.id == riderModel.id);
    if (index == -1) {
      throw CustomException(
          'This Rider is not present in the cache but it it is updated anyway, just reload the page');
    }
    _cache[index] = riderModel;
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
    required String phoneNumber,
    required String email,
    required String password,
  }) {
    if (name.length < 3) {
      throw CustomException(
          'Please enter an rider name which is longer than 3 letters');
    }

    if (phoneNumber.length < 3) {
      throw CustomException(
          'Please enter a phone number which is longer than 3 letters');
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

  //? rider user creation
  Future<RiderUser> _createRiderUser({
    required RiderModel riderModel,
  }) async {
    RiderUser riderUser = RiderUser(
      id: riderModel.id,
      name: riderModel.name,
      email: riderModel.email,
      createdAt: riderModel.createdAt,
    );
    await FirebaseFirestore.instance
        .collection(Collections.users)
        .doc(riderUser.id)
        .set(riderUser.toJson());
    return riderUser;
  }

  Future<RiderUser> _updateRiderUser({
    required RiderModel riderModel,
  }) async {
    RiderUser riderUser = RiderUser(
      id: riderModel.id,
      name: riderModel.name,
      email: riderModel.email,
      createdAt: riderModel.createdAt,
    );
    await FirebaseFirestore.instance
        .collection(Collections.users)
        .doc(riderUser.id)
        .update(riderUser.toJson());
    return riderUser;
  }

  Future<void> _deleteRiderUser(String id) async {
    await FirebaseFirestore.instance
        .collection(Collections.users)
        .doc(id)
        .delete();
  }

  //? storage
  Future<String> _riderProfileImage(XFile? profileImage, String riderId) async {
    if (profileImage == null) {
      throw CustomException('Please choose a rider profile image');
    }
    String? link = await _storageDatasource.upload(
      RemoteStorage.riderProfileImage,
      profileImage,
      riderId,
    );
    if (link == null) {
      throw CustomException('Can\'t upload image');
    }
    return link;
  }

  Future<String> _riderVehicleLicenseImage(
      XFile? licenseImage, String riderId) async {
    if (licenseImage == null) {
      throw CustomException('Please choose a rider vehicle license image');
    }
    String? link = await _storageDatasource.upload(
      RemoteStorage.riderVehicleLicense,
      licenseImage,
      riderId,
    );
    if (link == null) {
      throw CustomException('Can\'t upload image');
    }
    return link;
  }

  Future<String> _riderIdImage(
    XFile? idImage,
    String riderId,
  ) async {
    if (idImage == null) {
      throw CustomException('Please choose a rider ID image');
    }
    String? link = await _storageDatasource.upload(
      RemoteStorage.riderID,
      idImage,
      riderId,
    );
    if (link == null) {
      throw CustomException('Can\'t upload image');
    }
    return link;
  }

  Future<String> _riderProfileImageUpdate(
    XFile? profileImage,
    String riderId,
    String oldImage,
  ) async {
    if (profileImage == null) {
      return oldImage;
    }
    String? link = await _storageDatasource.upload(
      RemoteStorage.riderProfileImage,
      profileImage,
      riderId,
    );
    if (link == null) {
      throw CustomException('Can\'t upload image');
    }
    return link;
  }

  Future<String> _riderVehicleLicenseImageUpdate(
    XFile? licenseImage,
    String riderId,
    String oldImage,
  ) async {
    if (licenseImage == null) {
      return oldImage;
    }
    String? link = await _storageDatasource.upload(
      RemoteStorage.riderVehicleLicense,
      licenseImage,
      riderId,
    );
    if (link == null) {
      throw CustomException('Can\'t upload image');
    }
    return link;
  }

  Future<String> _riderIdImageUpdate(
    XFile? idImage,
    String riderId,
    String oldImage,
  ) async {
    if (idImage == null) {
      return oldImage;
    }
    String? link = await _storageDatasource.upload(
      RemoteStorage.riderID,
      idImage,
      riderId,
    );
    if (link == null) {
      throw CustomException('Can\'t upload image');
    }
    return link;
  }
}
