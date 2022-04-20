import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  FirebaseStorage storage = FirebaseStorage.instance;

  getURL(String path) {
    storage.refFromURL(path).getDownloadURL();
  }
}
