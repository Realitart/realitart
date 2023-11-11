import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  bool enable;
  DateTime createdAt;
  int id;
  String name;
  String description;

  CategoryModel({
    required this.enable,
    required this.createdAt,
    required this.id,
    required this.name,
    required this.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
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
