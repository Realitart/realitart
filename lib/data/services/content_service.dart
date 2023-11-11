import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:realitart/core/framework/url.dart';
import 'package:realitart/data/models/asset_model.dart';

class ContentService {
  Future<String?> getImage(int imageId) async {
    try {
      Uri url = Uri.parse("${contentStreamingAPI}images/$imageId");
      var response = await http.get(url);
      var jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return jsonResponse['url'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> getAudio(int audioId) async {
    try {
      Uri url = Uri.parse("${contentStreamingAPI}audios/$audioId");
      var response = await http.get(url);
      var jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return jsonResponse['url'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<AssetModel?> getAsset(int assetId) async {
    try {
      Uri url = Uri.parse("${contentStreamingAPI}assets/$assetId");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var x = AssetModel.fromJson(jsonResponse);
        return x;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
