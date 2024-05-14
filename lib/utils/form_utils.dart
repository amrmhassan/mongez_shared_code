import 'package:dio/dio.dart';

FormData formData(Map<String, dynamic> body) {
  FormData formData = FormData();
  body.forEach((key, value) {
    formData.fields.add(MapEntry(key, value));
  });
  return formData;
}
