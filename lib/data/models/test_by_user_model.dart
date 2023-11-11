import 'dart:convert';

TestByUserModel testByUserModelFromJson(String str) =>
    TestByUserModel.fromJson(json.decode(str));

String testByUserModelToJson(TestByUserModel data) =>
    json.encode(data.toJson());

class TestByUserModel {
  String name;
  int score;
  DateTime created;

  TestByUserModel({
    required this.name,
    required this.score,
    required this.created,
  });

  factory TestByUserModel.fromJson(Map<String, dynamic> json) =>
      TestByUserModel(
        name: json["name"],
        score: json["score"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "score": score,
        "created": created.toIso8601String(),
      };
}
