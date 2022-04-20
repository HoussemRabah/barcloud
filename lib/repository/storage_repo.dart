import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> getURL(String path) async {
    return await storage.refFromURL(path).getDownloadURL();
  }
}
