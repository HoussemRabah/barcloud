import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../core/constants.dart';
import '../modules/class.dart';
import 'package:http/http.dart' as http;

class DatabaseRepository {
  Future<http.Response> getData(
      {required String apiName, required String args}) async {
    String api = apiName;
    api = api + args;
    return await http.get(Uri.parse('$server/$api'),
        headers: {"Accept": "application/json"});
  }

  Future<TheUser?> getUser(String id) async {
    final response =
        await getData(apiName: "getUserById.php", args: "?userId=$id");

    try {
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        if (data["status"]) {
          return TheUser.fromJson(data["user"]);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<Task>?> getTasks(String id) async {
    List<Task>? tasks = [];
    final response =
        await getData(apiName: "getTasksOfUser.php", args: "?userId=$id");

    try {
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        if (data["status"]) {
          for (Map taskMap in data["tasks"]) tasks.add(fromMapTask(taskMap));
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return tasks;
  }

  Future<Zone?> getZone(String id) async {
    final response =
        await getData(apiName: "getZoneById.php", args: "?zoneId=$id");

    try {
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        if (data["status"]) {
          return (fromMapZone(data["zone"]));
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Zone fromMapZone(Map map) {
    return Zone(id: map["zoneId"], name: map["title"]);
  }

  Task fromMapTask(Map map) {
    return Task(
        id: map["taskId"],
        dower: map["agentId"],
        creator: map["adminId"],
        zone: map["zoneId"],
        type: TaskType.values
            .where((element) => element.name == map["type"])
            .first,
        title: map["title"],
        disc: map["disc"],
        deadline: Timestamp.fromMillisecondsSinceEpoch(
            DateFormat('MM-dd-yyyy hh:mm:ss')
                .parse(map["deadline"])
                .millisecondsSinceEpoch),
        process: TaskProcess.values
            .where((element) => element.name == map["process"])
            .first);
  }
}
