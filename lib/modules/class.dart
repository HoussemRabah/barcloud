import 'package:barcloud/repository/storage_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

enum Role { agent, ing, admin }

class TheUser {
  String id;
  String nom;
  String prenom;
  String img;
  String sub;
  Role role;
  User? user;
  String getFullName() => "$nom $prenom";
  Future<String> getImage() async => await StorageRepository().getURL(img);
  TheUser(
      {required this.id,
      required this.nom,
      required this.prenom,
      required this.sub,
      required this.role,
      required this.user,
      required this.img});
}

class Zone {
  String id;
  String name;
  Zone({required this.id, required this.name});
}

class ItemType {
  List<String> keys;
  String name;
  Map data;
  String categoryId;

  ItemType(
      {required this.name,
      required this.keys,
      required this.data,
      required this.categoryId});
}

class Item {
  String id;
  ItemType type;
  Item({required this.id, required this.type});
}
