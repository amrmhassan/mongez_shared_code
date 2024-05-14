import 'package:firebase_database/firebase_database.dart';

class MapUtils {
  static Map<String, dynamic> fixMap(Map map) {
    Map<String, dynamic> fixed = {};
    for (var entry in map.entries) {
      var value = entry.value;
      if (value is Map) {
        fixed[entry.key] = fixMap(value);
      } else {
        fixed[entry.key] = value;
      }
    }
    return fixed;
  }

  static Map<String, dynamic> fixSnapshot(DataSnapshot dataSnapshot) {
    var map = dataSnapshot.value as Map;
    return fixMap(map);
  }

  static List<Map<String, dynamic>> fixMapList(DataSnapshot snapshot) {
    var children = snapshot.children;
    var res = children.map((e) => fixSnapshot(e)).toList();
    return res;
  }
}
