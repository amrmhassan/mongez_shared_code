import 'package:mongez_shared_code/constants/endpoints.dart';
import 'package:mongez_shared_code/helpers/api_query.dart';
import 'package:mongez_shared_code/init/runtime_variables.dart';
import 'package:mongez_shared_code/mongez_shared_code.dart';

class ApiCaller {
  final String _coll;
  ApiCaller(this._coll) {
    dio.options.queryParameters[ApiQuery.coll] = _coll;
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    dio.options.queryParameters[ApiQuery.coll] = _coll;
    var res = await dio.get(Endpoints.gens);
    var body = res.data['data'] as List;
    List<Map<String, dynamic>> parsed =
        body.map((e) => MapUtils.fixMap(e)).toList();
    return parsed;
  }

  Future<void> add(Map<String, dynamic> data) async {
    dio.options.queryParameters[ApiQuery.coll] = _coll;
    await dio.post(Endpoints.gen, data: data);
  }

  Future<void> delete(String id) async {
    dio.options.queryParameters[ApiQuery.coll] = _coll;
    await dio.delete(Endpoints.gen, data: id);
  }

  Future<void> dropGen(String userId) async {
    dio.options.queryParameters[ApiQuery.coll] = _coll;
    dio.options.queryParameters[ApiQuery.userId] = userId;
    await dio.delete(Endpoints.dropGen);
  }

  Future<Map<String, dynamic>?> getOne(String id) async {
    dio.options.queryParameters[ApiQuery.coll] = _coll;
    dio.options.queryParameters[ApiQuery.id] = id;
    var res = await dio.get(Endpoints.gen);
    var body = res.data['data'];
    if (body == null) return null;
    var fixedMap = MapUtils.fixMap(body);

    dio.options.queryParameters[ApiQuery.id] = null;
    return fixedMap;
  }

  Future<void> updateOne(
    String id, {
    required Map<String, dynamic> data,
  }) async {
    dio.options.queryParameters[ApiQuery.coll] = _coll;
    dio.options.queryParameters[ApiQuery.id] = id;
    await dio.patch(Endpoints.gen, data: data);
    dio.options.queryParameters[ApiQuery.id] = null;
  }

  Future<List<Map<String, dynamic>>> getUserGen(String userId) async {
    dio.options.queryParameters[ApiQuery.coll] = _coll;
    dio.options.queryParameters[ApiQuery.userId] = userId;
    var res = await dio.get(Endpoints.userGen);
    dio.options.queryParameters[ApiQuery.userId] = null;
    var body = res.data['data'] as List;
    List<Map<String, dynamic>> parsed =
        body.map((e) => MapUtils.fixMap(e)).toList();
    return parsed;
  }

  Future<List<Map<String, dynamic>>> getFieldGen(
    String fieldName,
    String value,
  ) async {
    dio.options.queryParameters[ApiQuery.coll] = _coll;
    dio.options.queryParameters[ApiQuery.filedName] = fieldName;
    dio.options.queryParameters[ApiQuery.filedValue] = value;
    var res = await dio.get(Endpoints.fieldGen);
    dio.options.queryParameters[ApiQuery.filedName] = null;
    dio.options.queryParameters[ApiQuery.filedValue] = null;
    var body = res.data['data'] as List;
    List<Map<String, dynamic>> parsed =
        body.map((e) => MapUtils.fixMap(e)).toList();
    return parsed;
  }
}
