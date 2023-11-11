import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:realitart/core/framework/url.dart';
import 'package:realitart/data/models/artwork_model.dart';
import 'package:realitart/data/models/comment_model.dart';
import 'package:realitart/data/models/create_comment_model.dart';
import 'package:realitart/data/models/musseum_model.dart';

class MuseumWorkService {
  Future<List<MuseumModel?>> getMuseumsLst() async {
    try {
      Uri url = Uri.parse("${museumWorkAPI}museum?page=0&size=100");
      Map<String, String> headers = {"Content-Type": "application/json"};

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        List<MuseumModel?> list = [];
        String responseBody = utf8.decode(response.bodyBytes);
        var jsonResponse = json.decode(responseBody);
        var content = jsonResponse['content'];
        for (var item in content) {
          list.add(MuseumModel.fromJson(item));
        }
        return list;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<ArtworkModel?>> getArtworksLst({int? museumId, int? size}) async {
    try {
      Uri url = Uri.parse(
          "${museumWorkAPI}artwork?${museumId != null ? 'museumId=$museumId&' : ''}page=0&size=${size ?? '100'}");
      Map<String, String> headers = {"Content-Type": "application/json"};

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<ArtworkModel?> list = [];
        String responseBody = utf8.decode(response.bodyBytes);
        var jsonResponse = json.decode(responseBody);

        var content = jsonResponse['content'];
        for (var item in content) {
          list.add(ArtworkModel.fromJson(item));
        }

        return list;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<CommentModel?>> getComments(int artworkId, {int? size}) async {
    try {
      Uri url =
          Uri.parse("${museumWorkAPI}comment?page=0&size=${size ?? '100'}");
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "artworkId": artworkId.toString()
      };

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<CommentModel?> list = [];
        String responseBody = utf8.decode(response.bodyBytes);
        var jsonResponse = json.decode(responseBody);

        var content = jsonResponse['content'];
        for (var item in content) {
          list.add(CommentModel.fromJson(item));
        }

        return list;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<bool> createComment(CreateCommentModel request) async {
    try {
      Uri url = Uri.parse("${museumWorkAPI}comment");
      Map<String, String> headers = {"Content-Type": "application/json"};

      var response = await http.post(url,
          body: json.encode(request.toJson()), headers: headers);
      var jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        return jsonResponse['status'];
      } else {
        return jsonResponse['status'];
      }
    } catch (e) {
      return false;
    }
  }
}
