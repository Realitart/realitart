import 'dart:convert';

MuseumModel museumModelFromJson(String str) =>
    MuseumModel.fromJson(json.decode(str));

String museumModelToJson(MuseumModel data) => json.encode(data.toJson());

class MuseumModel {
  int id;
  String department;
  String name;
  String description;
  String address;
  String images;

  MuseumModel({
    required this.id,
    required this.department,
    required this.name,
    required this.description,
    required this.address,
    required this.images,
  });

  factory MuseumModel.fromJson(Map<String, dynamic> json) => MuseumModel(
        id: json["id"],
        department: json["department"],
        name: json["name"],
        description: json["description"],
        address: json["address"],
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "department": department,
        "name": name,
        "description": description,
        "address": address,
        "images": images,
      };
}
