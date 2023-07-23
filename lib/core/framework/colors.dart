import 'package:flutter/material.dart';

const primaryGrey = Color(0xFFF5F5F5);
const grey1 = Color(0xFFE7E8EA);
const black1 = Color(0xFF424242);
const txtGrey = Color(0xFF8F959E);
const txtBlack = Color(0xFF555555);
const MaterialColor basicColors = MaterialColor(
  0xFF3360FF, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
  <int, Color>{
    50: Color.fromRGBO(229, 235, 237, 0.37), //10%
    100: Color.fromRGBO(229, 235, 237, 0.37), //20%
    200: Color.fromRGBO(229, 235, 237, 0.37), //30%
    300: Color.fromRGBO(229, 235, 237, 0.37), //40%
    400: Color.fromRGBO(153, 153, 153, 0.67), //50%
    500: Color.fromRGBO(153, 153, 153, 0.94), //60%
    600: Color.fromRGBO(66, 66, 66, 1), //70%
    700: Color.fromRGBO(66, 66, 66, 1), //80%
    800: Color.fromRGBO(66, 66, 66, 1), //90%
    900: Color.fromRGBO(17, 24, 39, 1), //100%
  },
);
