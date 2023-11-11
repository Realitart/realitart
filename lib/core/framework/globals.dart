import 'dart:math';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

String loremIpsum =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

String generateRandomLoremIpsum(int size) {
  int random = Random().nextInt(loremIpsum.length - size);
  String result = loremIpsum.substring(random, random + size);
  return result;
}

String generateRandomImgUrl() {
  int random = Random().nextInt(50);
  String result = 'https://picsum.photos/id/$random/200/300';
  return result;
}

getPermissions() async {
  // You can request multiple permissions at once.
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.camera,
    Permission.storage,
    Permission.photos
  ].request();

  return (statuses[Permission.location]!.isGranted &&
          statuses[Permission.camera]!.isGranted &&
          statuses[Permission.storage]!.isGranted &&
          statuses[Permission.photos]!.isGranted)
      ? true
      : false;
}

//SharedPreference
setPreference(String key, dynamic value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  switch (value.runtimeType) {
    case String:
      await prefs.setString(key, value);
      break;
    case int:
      await prefs.setInt(key, value);
      break;
    case double:
      await prefs.setDouble(key, value);
      break;
    case bool:
      await prefs.setBool(key, value);
      break;
    case List<String>:
      await prefs.setStringList(key, value);
      break;
    default:
      await prefs.setString(key, value);
      break;
  }
}

getPreference(String key, {String type = 'string'}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  dynamic value;
  if (type == 'string') value = prefs.getString(key);
  if (type == 'list') value = prefs.getStringList(key);
  if (type == 'bool') value = prefs.getBool(key);
  return value;
}

deletePreference(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

cleanPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  //for in all prefs keys
  prefs.getKeys().forEach((key) async {
    await prefs.remove(key);
  });
}

//2023-10-05 a formato "5 de octubre, 2023"
String formatDateToTxt(String date) {
  List<String> lstDate = date.split('-');
  String result = lstDate[2] + ' de ';
  switch (lstDate[1]) {
    case '01':
      result += 'enero, ';
      break;
    case '02':
      result += 'febrero, ';
      break;
    case '03':
      result += 'marzo, ';
      break;
    case '04':
      result += 'abril, ';
      break;
    case '05':
      result += 'mayo, ';
      break;
    case '06':
      result += 'junio, ';
      break;
    case '07':
      result += 'julio, ';
      break;
    case '08':
      result += 'agosto, ';
      break;
    case '09':
      result += 'septiembre, ';
      break;
    case '10':
      result += 'octubre, ';
      break;
    case '11':
      result += 'noviembre, ';
      break;
    case '12':
      result += 'diciembre, ';
      break;
    default:
  }
  result += lstDate[0];
  return result;
}
