import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:realitart/core/framework/globals.dart';
import 'package:realitart/core/framework/url.dart';
import 'package:realitart/data/models/auth_model.dart';
import 'package:realitart/data/models/user_model.dart';

class AuthService {
  Future<bool> createUser(UserModel userRequest) async {
    try {
      Uri url = Uri.parse("${accoundManaggerAPI}users");
      Map<String, String> headers = {"Content-Type": "application/json"};

      var response = await http.post(url,
          body: json.encode(userRequest.toJson()), headers: headers);
      var jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        setPreference('user', json.encode(UserModel.fromJson(jsonResponse)));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<UserModel?> getUser(String userIdOrUsername) async {
    try {
      Uri url = Uri.parse("${accoundManaggerAPI}users/$userIdOrUsername");
      var response = await http.get(url);
      var jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonResponse);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> login(AuthModel authRequest) async {
    try {
      Uri url = Uri.parse("${authAPI}login");
      Map<String, String> headers = {"Content-Type": "application/json"};
      var response = await http.post(url,
          body: json.encode(authRequest.toJson()), headers: headers);
      if (response.statusCode == 200) {
        return getUser(authRequest.username).then((value) {
          if (value != null) {
            setPreference('user', json.encode(value));
            return true;
          } else {
            return false;
          }
        });
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(AuthModel authRequest) async {
    try {
      Uri url = Uri.parse("${authAPI}register");
      var body = json.encode(authRequest.toJson());
      Map<String, String> headers = {"Content-Type": "application/json"};
      var response = await http.post(url, body: body, headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
