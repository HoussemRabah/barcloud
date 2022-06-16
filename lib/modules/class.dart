import 'package:barcloud/repository/database_repo.dart';
import 'package:barcloud/repository/storage_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

enum Role { agent, ing, admin, chef }

enum TaskType { checklist, edit, add }

enum TaskProcess { wait, begin, error, end }

TaskType getTaskType(String type) {
  switch (type) {
    case "checklist":
      return TaskType.checklist;

    case "edit":
      return TaskType.edit;

    case "add":
      return TaskType.add;
  }
  return TaskType.checklist;
}

TaskProcess getTaskProcess(String process) {
  switch (process) {
    case "wait":
      return TaskProcess.wait;

    case "begin":
      return TaskProcess.begin;

    case "error":
      return TaskProcess.error;

    case "end":
      return TaskProcess.end;
  }
  return TaskProcess.wait;
}

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
      this.user,
      required this.img});
  factory TheUser.fromJson(Map<String, dynamic> json) {
    return TheUser(
      id: json['userId'],
      img: json['image'],
      nom: json['nom'],
      prenom: json['prenom'],
      role:
          Role.values.where((element) => (element.name == json['role'])).first,
      sub: json['sub'],
    );
  }
}

class Zone {
  String id;
  String name;
  Zone({required this.id, required this.name});
}

class Categorie {
  String id;
  String name;
  Categorie({required this.id, required this.name});
}

class SubCategorie {
  String id;
  String catId;
  String name;
  SubCategorie({required this.id, required this.catId, required this.name});
}

class ItemType {
  String id;
  String name;
  String subCategoryId;

  ItemType({required this.name, required this.id, required this.subCategoryId});
}

class Item {
  String id;
  String name;
  String image;
  ItemType type;
  String zoneId;
  Item(
      {required this.id,
      required this.zoneId,
      required this.type,
      required this.name,
      required this.image});
}

class Task {
  String id;
  String dower;
  String creator;
  String zone;
  TaskType type;
  String title;
  String disc;
  Timestamp deadline;
  TaskProcess process;
  Future<TheUser?> getDower() => DatabaseRepository().getUser(dower);
  Future<TheUser?> getCreator() => DatabaseRepository().getUser(creator);
  Future<Zone?> getZone() => DatabaseRepository().getZone(zone);
  Task(
      {required this.id,
      required this.dower,
      required this.zone,
      required this.type,
      required this.title,
      required this.disc,
      required this.deadline,
      required this.process,
      required this.creator});
}
