import 'dart:convert';

CreateCommentModel createCommentModelFromJson(String str) =>
    CreateCommentModel.fromJson(json.decode(str));

String createCommentModelToJson(CreateCommentModel data) =>
    json.encode(data.toJson());

class CreateCommentModel {
  int userId;
  int artworkId;
  String description;

  CreateCommentModel({
    required this.userId,
    required this.artworkId,
    required this.description,
  });

  factory CreateCommentModel.fromJson(Map<String, dynamic> json) =>
      CreateCommentModel(
        userId: json["userId"],
        artworkId: json["artworkId"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "artworkId": artworkId,
        "description": description,
      };
}
