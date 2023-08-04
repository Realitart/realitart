import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realitart/core/framework/colors.dart';

class DetailAppBar extends StatefulWidget {
  final String imgPath;
  const DetailAppBar({Key? key, required this.imgPath}) : super(key: key);

  @override
  State<DetailAppBar> createState() => _DetailAppBarState();
}

class _DetailAppBarState extends State<DetailAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        expandedHeight: MediaQuery.of(context).size.height * 0.6,
        backgroundColor: primaryGrey,
        elevation: 8,
        stretch: true,
        pinned: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        flexibleSpace: FlexibleSpaceBar(
          background: Image.network(
            widget.imgPath,
            fit: BoxFit.cover,
          ),
          stretchModes: const [
            StretchMode.zoomBackground,
            StretchMode.blurBackground,
          ],
        ),
        leadingWidth: 60.0,
        leading: Container(
            margin: const EdgeInsets.only(left: 4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(56.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: grey1.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15)),
                    child: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white, size: 20),
                  ),
                ),
              ),
            )),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
              height: 35,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: primaryGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: black1,
                  borderRadius: BorderRadius.circular(10),
                ),
              )),
        ));
  }
}
