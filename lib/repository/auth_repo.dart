import 'dart:convert';

import 'package:barcloud/UI/screens/pages/login.dart';
import 'package:barcloud/logic/bloc/auth/auth_bloc.dart';
import 'package:barcloud/modules/class.dart';
import 'package:barcloud/repository/database_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../core/constants.dart';

class AuthRepository {
  TheUser? user;
  String? errorMessage;

  Future<bool> signIn({required String email, required String password}) async {
    String api = "auth.php";
    api = api + "?userId=" + email;
    api = api + "&password=" + password;
    final response = await http.get(Uri.parse('$server/$api'),
        headers: {"Accept": "application/json"});

    try {
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        if (data["status"]) {
          this.user = TheUser.fromJson(data["user"]);
          this.errorMessage = null;
          return true;
        } else {
          this.errorMessage = data["message"];
          return false;
        }
      } else {
        this.errorMessage = 'oops! erreur';

        return false;
      }
    } catch (e) {
      this.errorMessage = 'oops! erreur';

      return false;
    }
  }

 
}
