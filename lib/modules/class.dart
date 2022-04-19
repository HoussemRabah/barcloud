import 'package:flutter/foundation.dart';

enum Role { agent, ing, admin }

class User {
  String id;
  String nom;
  String prenom;
  String sub;
  Role role;

  String getFullName() => "$nom $prenom";
  User(
      {required this.id,
      required this.nom,
      required this.prenom,
      required this.sub,
      required this.role});
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
