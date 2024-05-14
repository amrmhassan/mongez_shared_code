import 'dart:io';

import 'package:mongez_shared_code/constants/shared_pref_constants.dart';
import 'package:mongez_shared_code/helpers/shared_pref_helper.dart';
import 'package:mongez_shared_code/init/runtime_variables.dart';

class InitDio {
  Future init() async {
    String? token =
        await SharedPrefHelper.getString(SharedPrefKeys.accessToken);
    if (token == null) {
      return;
    }
    logger.i('User access token is $token');
    dio.options.headers
        .addAll({HttpHeaders.authorizationHeader: 'Bearer $token'});
  }
}
