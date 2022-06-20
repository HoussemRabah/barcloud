import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../UI/screens/pages/login.dart';
import '../core/constants.dart';
import '../modules/class.dart';
import 'package:http/http.dart' as http;

class DatabaseRepository {
  http.Client client = new http.Client();
  Future<http.Response> getData(
      {required String apiName, required String args}) async {
    String api = apiName;
    api = api + args;
    print(Uri.parse('$server$api'));
    http.Response res = await client
        .get(Uri.parse("$server$api"), headers: {"Accept": "application/json"});
    return res;
  }

  Future<bool> addTask(String agentId, String adminId, String zoneId,
      String title, String disc, String type, String deadline) async {
    final response = await getData(
        apiName: "addTask.php",
        args:
            "?agentId=$agentId&zoneId=$zoneId&adminId=$adminId&title=$title&disc=$disc&type=$type&deadline=$deadline");
    try {
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        if (data["status"]) {
          print(data["message"]);
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Event>?> getEvents() async {
    List<Event>? events = [];
    final response = await getData(apiName: "getevents.php", args: "");
    try {
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        if (data["status"]) {
          for (Map taskMap in data["events"])
            events.add(fromMapEvent(taskMap["events"]));
        } else {
          return [];
        }
      } else {
        print(response.body);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return events;
  }

  Future<List<TheUser>?> getAllUsers() async {
    List<TheUser>? users = [];
    final response = await getData(apiName: "getAllUsers.php", args: "");
    try {
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        if (data["status"]) {
          for (Map taskMap in data["users"])
            users.add(TheUser.fromJson(taskMap as Map<String, dynamic>));
        } else {
          return [];
        }
      } else {
        print(response.body);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return users;
  }

  Future<List<Task>?> getAllTasks() async {
    List<Task>? tasks = [];
    final response = await getData(apiName: "getAllTasks.php", args: "");
    try {
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        if (data["status"]) {
          for (Map taskMap in data["tasks"]) tasks.add(fromMapTask(taskMap));
        } else {
          return [];
        }
      } else {
        print(response.body);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return tasks;
  }

  Future<List<Zone>?> getAllZones() async {
    List<Zone>? zones = [];
    final response = await getData(apiName: "getZones.php", args: "");

    try {
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);

        if (data["status"]) {
          for (Map zoneMap in data["zones"]) zones.add(fromMapZone(zoneMap));
        } else {
          return [];
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return zones;
  }

  Future<TheUser?> getUser(String id) async {
    final response =
        await getData(apiName: "getUserById.php", args: "?userId=$id");
    print(id);
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
      print(e);
      return null;
    }
  }

  Future<bool> changeData(
      String dataId, String itemId, String userId, String data) async {
    final response = await getData(
        apiName: "setData.php",
        args: "?userId=$userId&dataId=$dataId&data=$data&itemId=$itemId");

    try {
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        if (data["status"]) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
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
          return [];
        }
      } else {
        print(response.body);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return tasks;
  }

  Future<List<SubCategorie>?> getSubCategories() async {
    List<SubCategorie>? categories = [];
    final response = await getData(apiName: "getSubCats.php", args: "");

    try {
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);

        if (data["status"]) {
          for (Map zoneMap in data["subCategories"])
            categories.add(fromMapSubCategorie(zoneMap));
        } else {
          return [];
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return categories;
  }

  Future<List<ItemType>?> getItemTypes() async {
    List<ItemType>? categories = [];
    final response = await getData(apiName: "getItemTypes.php", args: "");

    try {
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);

        if (data["status"]) {
          for (Map zoneMap in data["itemTypes"])
            categories.add(fromMapItemType(zoneMap));
        } else {
          return [];
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return categories;
  }

  Future<List<Categorie>?> getCategories() async {
    List<Categorie>? categories = [];
    final response = await getData(apiName: "getCategories.php", args: "");

    try {
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);

        if (data["status"]) {
          for (Map zoneMap in data["categories"])
            categories.add(fromMapCategorie(zoneMap));
        } else {
          return [];
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return categories;
  }

  Future<List<Item>?> getItemsByZone(
      List<ItemType> itemTypes, String zoneId) async {
    List<Item>? items = [];

    try {
      final response =
          await getData(apiName: "getitembyzone.php", args: "?zoneId=$zoneId");

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);

        if (data["status"]) {
          for (Map zoneMap in data["items"])
            items.add(fromMapItem(zoneMap, itemTypes));
        } else {
          return [];
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return items;
  }

  Future<List<Item>?> getItems(List<ItemType> itemTypes) async {
    List<Item>? items = [];
    final response = await getData(apiName: "getItems.php", args: "");

    try {
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);

        if (data["status"]) {
          for (Map zoneMap in data["items"])
            items.add(fromMapItem(zoneMap, itemTypes));
        } else {
          return [];
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return items;
  }

  Future<List<DataChamp>?> getDataChamps(String itemTypeId) async {
    List<DataChamp>? zones = [];
    final response = await getData(
        apiName: "getDataChamps.php", args: "?itemTypeId=$itemTypeId");

    try {
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);

        if (data["status"]) {
          for (Map zoneMap in data["data"])
            zones.add(fromMapDataChamps(zoneMap));
        } else {
          return [];
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return zones;
  }

  Future<List<ItemData>?> getItemData(String itemId) async {
    List<ItemData>? zones = [];
    final response =
        await getData(apiName: "getDataByItem.php", args: "?itemId=$itemId");

    try {
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);

        if (data["status"]) {
          for (Map zoneMap in data["data"]) zones.add(fromMapItemData(zoneMap));
        } else {
          return [];
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return zones;
  }

  Future<List<Zone>?> getZones(String userId) async {
    List<Zone>? zones = [];
    final response =
        await getData(apiName: "getZoneByUser.php", args: "?userId=$userId");

    try {
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);

        if (data["status"]) {
          for (Map zoneMap in data["zones"]) zones.add(fromMapZone(zoneMap));
        } else {
          return [];
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return zones;
  }

  Future<String?> addItem(String zoneId, String itemTypeId, List<String> data,
      List<String> champs) async {
    try {
      final response = await getData(
          apiName: "additem.php",
          args: "?zoneId=$zoneId&itemTypeId=$itemTypeId");
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        print(data);
        if (data["status"]) {
          for (int i = 0; i < data.length; i++) {
            await getData(
                apiName: "addDataByChamp.php",
                args:
                    "?champId=${champs[i]}&data=${data[i]}&itemTypeId=$itemTypeId&itemId=${data["item"]}");
          }
          return ((data["item"]));
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

  Event fromMapEvent(Map map) {
    return Event(
        eventId: map["eventId"],
        itemId: map["itemId"],
        checklistId: map["checklist"],
        taskId: map["taskId"],
        date: map["date"],
        data: map["data"]);
  }

  DataChamp fromMapDataChamps(Map map) {
    return DataChamp(
        id: map["dataChampId"],
        name: map["dataChampName"],
        type: map["dataChampType"]);
  }

  ItemData fromMapItemData(Map map) {
    return ItemData(
        dataId: map["dataId"],
        data: map["data"],
        champName: map["dataChampName"],
        customAcess: map["customAcess"] == "y" ? false : true);
  }

  Zone fromMapZone(Map map) {
    return Zone(id: map["zoneId"], name: map["title"]);
  }

  ItemType fromMapItemType(Map map) {
    return ItemType(
        id: map["itemTypeId"],
        subCategoryId: map["itemSubCategoryId"],
        name: map["typeName"]);
  }

  Item fromMapItem(Map map, List<ItemType> itemTypes) {
    return Item(
        id: map["itemId"],
        name: map["name"],
        image: map["image"],
        zoneId: map["zoneId"],
        type: itemTypes
            .where((element) => element.id == map["itemTypeId"])
            .first);
  }

  Categorie fromMapCategorie(Map map) {
    return Categorie(id: map["itemCategoryId"], name: map["catName"]);
  }

  SubCategorie fromMapSubCategorie(Map map) {
    return SubCategorie(
        catId: map["itemCategoryId"],
        name: map["subName"],
        id: map["itemSubCategoryId"]);
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
