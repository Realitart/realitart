import 'dart:convert';

AssetModel assetModelFromJson(String str) =>
    AssetModel.fromJson(json.decode(str));

String assetModelToJson(AssetModel data) => json.encode(data.toJson());

class AssetModel {
  bool enable;
  DateTime createdAt;
  int id;
  int artworkId;
  String url;
  double positionX;
  double positionY;
  double positionZ;
  double scaleX;
  double scaleY;
  double scaleZ;
  double rotationX;
  double rotationY;
  double rotationZ;

  AssetModel({
    required this.enable,
    required this.createdAt,
    required this.id,
    required this.artworkId,
    required this.url,
    required this.positionX,
    required this.positionY,
    required this.positionZ,
    required this.scaleX,
    required this.scaleY,
    required this.scaleZ,
    required this.rotationX,
    required this.rotationY,
    required this.rotationZ,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) => AssetModel(
        enable: json["enable"],
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        artworkId: json["artworkId"],
        url: json["url"],
        positionX: json["positionX"] is int
            ? (json["positionX"] as int).toDouble()
            : json["positionX"],
        positionY: json["positionY"] is int
            ? (json["positionY"] as int).toDouble()
            : json["positionY"],
        positionZ: json["positionZ"] is int
            ? (json["positionZ"] as int).toDouble()
            : json["positionZ"],
        scaleX: json["scaleX"] is int
            ? (json["scaleX"] as int).toDouble()
            : json["scaleX"],
        scaleY: json["scaleY"] is int
            ? (json["scaleY"] as int).toDouble()
            : json["scaleY"],
        scaleZ: json["scaleZ"] is int
            ? (json["scaleZ"] as int).toDouble()
            : json["scaleZ"],
        rotationX: json["rotationX"] is int
            ? (json["rotationX"] as int).toDouble()
            : json["rotationX"],
        rotationY: json["rotationY"] is int
            ? (json["rotationY"] as int).toDouble()
            : json["rotationY"],
        rotationZ: json["rotationZ"] is int
            ? (json["rotationZ"] as int).toDouble()
            : json["rotationZ"],
      );

  Map<String, dynamic> toJson() => {
        "enable": enable,
        "createdAt": createdAt.toIso8601String(),
        "id": id,
        "artworkId": artworkId,
        "url": url,
        "positionX": positionX,
        "positionY": positionY,
        "positionZ": positionZ,
        "scaleX": scaleX,
        "scaleY": scaleY,
        "scaleZ": scaleZ,
        "rotationX": rotationX,
        "rotationY": rotationY,
        "rotationZ": rotationZ,
      };
}
