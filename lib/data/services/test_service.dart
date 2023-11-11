import 'dart:convert';

import 'package:realitart/core/framework/globals.dart';
import 'package:realitart/core/framework/url.dart';
import 'package:realitart/data/models/test_by_user_model.dart';
import 'package:realitart/data/models/test_model.dart';
import 'package:http/http.dart' as http;
import 'package:realitart/data/models/test_response_model.dart';
import 'package:realitart/data/models/user_model.dart';

class TestService {
  Future<TestModel?> getTestByCode(String code) async {
    try {
      Uri url = Uri.parse("${testAPI}test/complete?code=$code");
      Map<String, String> headers = {"Content-Type": "application/json"};

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);
        var jsonResponse = json.decode(responseBody);
        return TestModel.fromJson(jsonResponse);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<TestModel?> getTestById(String testId) async {
    try {
      Uri url = Uri.parse("${testAPI}test/complete?testId=$testId");
      Map<String, String> headers = {"Content-Type": "application/json"};

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);
        var jsonResponse = json.decode(responseBody);
        return TestModel.fromJson(jsonResponse);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool?> sendCompleteTest(TestResponseModel completeTest) async {
    try {
      completeTest.expiration = DateTime.now();
      completeTest.start = DateTime.now();
      //get userId
      String userData = await getPreference('user');
      UserModel userModel = UserModel.fromJson(json.decode(userData));

      Uri url = Uri.parse("${testAPI}test/send?userId=${userModel.id}");
      Map<String, String> headers = {"Content-Type": "application/json"};
      var body = json.encode(completeTest.toJson());
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<TestByUserModel>> getTestByUser() async {
    try {
      //get userId
      String userData = await getPreference('user');
      UserModel userModel = UserModel.fromJson(json.decode(userData));

      Uri url =
          Uri.parse("${testAPI}test/all/student?studentId=${userModel.id}");
      Map<String, String> headers = {"Content-Type": "application/json"};
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);
        var jsonResponse = json.decode(responseBody);
        List<TestByUserModel> lstTest = [];
        for (var item in jsonResponse) {
          lstTest.add(TestByUserModel.fromJson(item));
        }
        return lstTest;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
