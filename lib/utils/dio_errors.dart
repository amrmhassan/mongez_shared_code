import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mongez_shared_code/errors/custom_exception.dart';
import 'package:mongez_shared_code/init/runtime_variables.dart';

Future<T> handleDioError<T>(Future<T> Function() callback) async {
  try {
    return await callback();
  } on DioException catch (e) {
    String? message = e.response?.data['error'];
    String? message2 = e.response?.data['message'];
    logger.e(message);
    throw CustomException(message ?? message2 ?? 'Unknown Error');
  } catch (e) {
    logger.e(e);
    rethrow;
  }
}
