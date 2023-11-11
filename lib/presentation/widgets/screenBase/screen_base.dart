import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/core/framework/globals.dart';
import 'package:realitart/data/models/user_model.dart';
import 'package:realitart/presentation/widgets/circlularimg.dart';
import 'package:realitart/presentation/widgets/screenBase/lateral_drawer.dart';

class ScreenBase extends StatefulWidget {
  final Widget body;
  const ScreenBase({Key? key, required this.body}) : super(key: key);

  @override
  State<ScreenBase> createState() => _ScreenBaseState();
}

class _ScreenBaseState extends State<ScreenBase> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  // Create a key
  @override
  void initState() {
    super.initState();
  }

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
      ),
      body: SingleChildScrollView(child: widget.body),
    );
  }
}
