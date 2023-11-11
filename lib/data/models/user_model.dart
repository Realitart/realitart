import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int id;
  int idUserType;
  String username;
  String name;
  String password;
  String email;
  bool activeNotifications;
  int imageId;

  UserModel({
    required this.id,
    required this.idUserType,
    required this.username,
    required this.name,
    required this.password,
    required this.email,
    required this.activeNotifications,
    required this.imageId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        idUserType: json["idUserType"],
        username: json["username"],
        name: json["name"],
        password: json["password"] ?? '',
        email: json["email"],
        activeNotifications: json["activeNotifications"],
        imageId: json["imageId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idUserType": idUserType,
        "username": username,
        "name": name,
        "password": password,
        "email": email,
        "activeNotifications": activeNotifications,
        "imageId": imageId,
      };
}
