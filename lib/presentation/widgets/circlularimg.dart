import 'package:flutter/material.dart';
import 'package:realitart/core/framework/colors.dart';

class CircularImg extends StatelessWidget {
  const CircularImg({Key? key, this.pathImg = '', this.vHeight, this.vWidth})
      : super(key: key);
  final String pathImg;
  final double? vHeight;
  final double? vWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: vHeight ?? 55,
        width: vWidth ?? 55,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: black1, width: 2.5)),
        child: CircleAvatar(
          backgroundImage: NetworkImage(pathImg),
          backgroundColor: Colors.white,
        ));
  }
}
