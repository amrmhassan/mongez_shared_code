import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class WebStorageDatasource {
  Future<String?> upload(
    String ref,
    XFile? file,
    String child,
  ) async {
    if (file == null) return null;
    var bytes = await file.readAsBytes();
    var res =
        await FirebaseStorage.instance.ref(ref).child(child).putData(bytes);
    return res.ref.getDownloadURL();
  }

  Future<void> delete(String url) async {
    await FirebaseStorage.instance.refFromURL(url).delete();
  }
}
