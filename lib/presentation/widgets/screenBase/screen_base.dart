import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/presentation/widgets/circlularimg.dart';
import 'package:realitart/presentation/widgets/screenBase/lateral_drawer.dart';

class ScreenBase extends StatefulWidget {
  final Widget body;
  ScreenBase({Key? key, required this.body}) : super(key: key);

  @override
  State<ScreenBase> createState() => _ScreenBaseState();
}

class _ScreenBaseState extends State<ScreenBase> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  // Create a key
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawerEnableOpenDragGesture: true,
      drawerEdgeDragWidth: 50,
      drawer: const LateralDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/svg/menu_icon.svg',
          ),
          onPressed: () => _key.currentState!.openDrawer(),
        ),
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
      ),
      body: SingleChildScrollView(child: widget.body),
    );
  }
}
