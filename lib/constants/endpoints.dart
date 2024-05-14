import 'package:mongez_shared_code/constants/links.dart';

class Endpoints {
  static String endpoint(String endpoint) {
    return Links.serverUrl + endpoint;
  }

  // gen - generic
  static String get gen => endpoint('/gen');
  static String get gens => endpoint('/gens');
  static String get dropGen => endpoint('/dropGen');
  static String get userGen => endpoint('/userGen');
  static String get fieldGen => endpoint('/fieldGen');
  static String get searchProduct => endpoint('/searchProduct');
  static String get collectionSample => endpoint('/collectionSample');
  static String get getLatest50Products => endpoint('/getLatest50Products');
}
