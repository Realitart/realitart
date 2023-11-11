import 'dart:convert';

ArtworkModel artworkModelFromJson(String str) =>
    ArtworkModel.fromJson(json.decode(str));

String artworkModelToJson(ArtworkModel data) => json.encode(data.toJson());

class ArtworkModel {
  bool enable;
  DateTime createdAt;
  int id;
  MuseumId museumId;
  CategoryId categoryId;
  int assetId;
  int audioId;
  String name;
  String summary;
  double raiting;
  String images;

  ArtworkModel({
    required this.enable,
    required this.createdAt,
    required this.id,
    required this.museumId,
    required this.categoryId,
    required this.assetId,
    required this.audioId,
    required this.name,
    required this.summary,
    required this.raiting,
    required this.images,
  });

  factory ArtworkModel.fromJson(Map<String, dynamic> json) => ArtworkModel(
        enable: json["enable"],
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        museumId: MuseumId.fromJson(json["museumId"]),
        categoryId: CategoryId.fromJson(json["categoryId"]),
        assetId: json["assetId"],
        audioId: json["audioId"],
        name: json["name"],
        summary: json["summary"],
        raiting: json["raiting"],
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "enable": enable,
        "createdAt": createdAt.toIso8601String(),
        "id": id,
        "museumId": museumId.toJson(),
        "categoryId": categoryId.toJson(),
        "assetId": assetId,
        "audioId": audioId,
        "name": name,
        "summary": summary,
        "raiting": raiting,
        "images": images,
      };
}

class CategoryId {
  bool enable;
  DateTime createdAt;
  int id;
  String name;
  String description;

  CategoryId({
    required this.enable,
    required this.createdAt,
    required this.id,
    required this.name,
    required this.description,
  });

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        enable: json["enable"],
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "enable": enable,
        "createdAt": createdAt.toIso8601String(),
        "id": id,
        "name": name,
        "description": description,
      };
}

class MuseumId {
  bool enable;
  DateTime createdAt;
  int id;
  int departmentId;
  String name;
  String description;
  String address;
  String images;

  MuseumId({
    required this.enable,
    required this.createdAt,
    required this.id,
    required this.departmentId,
    required this.name,
    required this.description,
    required this.address,
    required this.images,
  });

  factory MuseumId.fromJson(Map<String, dynamic> json) => MuseumId(
        enable: json["enable"],
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        departmentId: json["departmentId"],
        name: json["name"],
        description: json["description"],
        address: json["address"],
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "enable": enable,
        "createdAt": createdAt.toIso8601String(),
        "id": id,
        "departmentId": departmentId,
        "name": name,
        "description": description,
        "address": address,
        "images": images,
      };
}
