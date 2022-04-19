import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../modules/class.dart';

class DatabaseRepository {
  Future<Map> getMap(String path) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.doc(path).get();
    return doc.data() as Map;
  }

  TheUser fromMapTheUser(Map map, User user) {
    return TheUser(
        id: map["id"],
        nom: map["nom"],
        prenom: map["prenom"],
        sub: map["sub"],
        role: (map["role"] == "agent")
            ? Role.agent
            : (map["role"] == "admin")
                ? Role.admin
                : Role.ing,
        user: user);
  }
}
