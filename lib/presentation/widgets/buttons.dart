import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final double width;
  final double height;
  final double txtSize;
  final Color colorDefault;
  final Color borderColorDefault;
  final Color textColor;
  final VoidCallback onPressed;
  final double radius;
  // ignore: use_key_in_widget_constructors
  const AppButton({
    required this.label,
    required this.width,
    this.colorDefault = Colors.transparent,
    this.borderColorDefault = Colors.transparent,
    this.textColor = Colors.white,
    this.height = 50,
    this.txtSize = 22,
    required this.onPressed,
    this.radius = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          color: colorDefault,
          border: Border.all(color: borderColorDefault, width: 3)),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          onTap: onPressed,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Gilroy_bold',
                fontWeight: FontWeight.w400,
                fontSize: txtSize,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppButtonIcon extends StatelessWidget {
  final String label;
  final double width;
  final double height;
  final Color colorDefault;
  final Color borderColorDefault;
  final Color textColor;
  final VoidCallback onPressed;
  final double radius;
  final IconData? icono;
  final String fontFamily;
  // ignore: use_key_in_widget_constructors
  const AppButtonIcon(
      {required this.label,
      required this.width,
      this.colorDefault = Colors.transparent,
      this.borderColorDefault = Colors.transparent,
      this.textColor = Colors.white,
      this.height = 50,
      required this.onPressed,
      this.radius = 20.0,
      this.icono,
      this.fontFamily = 'letra_Telefonica_regular'});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          color: colorDefault,
          border: Border.all(color: borderColorDefault, width: 2)),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          onTap: onPressed,
          child: Center(
            child: icono != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icono, color: textColor, size: 18),
                      Text(
                        label,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: textColor,
                        ),
                      ),
                    ],
                  )
                : Text(
                    label,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class BtnPreload extends StatelessWidget {
  final double ancho;
  final double alto;
  final EdgeInsetsGeometry paddingBtn;
  final Color colorDefault;
  final Color borderColorDefault;
  final double bordeRadius;
  final Color colorProgress;

  // ignore: use_key_in_widget_constructors
  const BtnPreload(
      {this.ancho = double.infinity,
      this.colorDefault = Colors.transparent,
      this.borderColorDefault = Colors.transparent,
      this.bordeRadius = 25,
      this.colorProgress = Colors.white,
      this.paddingBtn = const EdgeInsets.all(10),
      this.alto = 45});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: alto,
      width: ancho,
      decoration: BoxDecoration(
          color: colorDefault,
          borderRadius: BorderRadius.circular(bordeRadius),
          border: Border.all(color: borderColorDefault, width: 2)),
      child: Container(
          padding: paddingBtn,
          child: Center(
              child: CircularProgressIndicator(
            strokeWidth: 3,
            color: colorProgress,
          ))),
    );
  }
}
