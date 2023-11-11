import 'dart:convert';

CommentModel commentModelFromJson(String str) =>
    CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  bool enable;
  int id;
  int userId;
  String description;

  CommentModel({
    required this.enable,
    required this.id,
    required this.userId,
    required this.description,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        enable: json["enable"],
        id: json["id"],
        userId: json["userId"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "enable": enable,
        "id": id,
        "userId": userId,
        "description": description,
      };
}
