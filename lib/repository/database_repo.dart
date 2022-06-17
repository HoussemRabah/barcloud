import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  ItemData fromMapItemData(Map map) {
    return ItemData(
        dataId: map["dataId"],
        data: map["data"],
        champName: map["dataChampName"],
        customAcess: map["customAcess"]);
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
