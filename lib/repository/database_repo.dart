import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../modules/class.dart';

class DatabaseRepository {
  Future<Map> getMap(String path) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.doc(path).get();
    return doc.data() as Map;
  }

  Future<TheUser> getUser(String id) async {
    return fromMapTheUser(await getMap("/user/$id/"), null);
  }

  Future<Zone> getZone(String id) async {
    return fromMapZone(await getMap("/zone/$id/"));
  }

  Future<Task> getTask(String taskId, String id) async {
    return fromMapTask(await getMap("/task/$id/tasks/$taskId"));
  }

  Future<List<Task>?> getTasks(String id) async {
    List<Task>? tasks = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("task/$id/tasks/").get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    allData.forEach((map) {
      if (tasks != null) tasks.add(fromMapTask(map as Map<String, dynamic>));
    });
    return tasks;
  }

  onTaskChange(String id, Function todo) async {
    FirebaseFirestore.instance
        .collection("task/$id/tasks/")
        .snapshots()
        .listen((event) {
      todo();
    });
  }

  TheUser fromMapTheUser(Map map, User? user) {
    return TheUser(
        id: map["id"],
        nom: map["nom"],
        prenom: map["prenom"],
        img: map["img"],
        sub: map["sub"],
        role: (map["role"] == "agent")
            ? Role.agent
            : (map["role"] == "admin")
                ? Role.admin
                : Role.ing,
        user: user);
  }

  Zone fromMapZone(Map map) {
    return Zone(id: map["id"], name: map["nom"]);
  }

  Task fromMapTask(Map map) {
    return Task(
        id: map["id"],
        dower: map["dower"],
        zone: map["zone"],
        type: getTaskType(map["type"]),
        title: map["title"],
        disc: map["disc"],
        deadline: (map["deadline"] as Timestamp),
        process: getTaskProcess(map["process"]));
  }
}
