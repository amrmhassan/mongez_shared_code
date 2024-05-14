// ignore_for_file: dead_code

import 'package:mongez_shared_code/errors/custom_exception.dart';
import 'package:mongez_shared_code/init/runtime_variables.dart';

String get myUID {
  String? myID = firebaseAuth.currentUser?.uid;
  if (myID == null) {
    throw const CustomException('You are not logged in');
  }
  return myID;
}
