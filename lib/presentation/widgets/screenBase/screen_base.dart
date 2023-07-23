import 'package:flutter/material.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/presentation/widgets/circlularimg.dart';
import 'package:realitart/presentation/widgets/screenBase/lateral_drawer.dart';

class ScreenBase extends StatelessWidget {
  final Widget body;
  ScreenBase({Key? key, required this.body}) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawerEnableOpenDragGesture: false,
      drawer: const LateralDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              'Hola usuario',
              style: TextStyle(
                  color: txtBlack,
                  fontSize: 18,
                  fontFamily: 'Gilroy_semibold',
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(width: 8), // Add spacing between text and circle
            CircularImg(
                pathImg: "assets/imgs/logo.png", vHeight: 40, vWidth: 40),
          ],
        ),
        actions: [], // Empty actions list to avoid duplicated circle
      ),
      body: body,
    );
  }
}
