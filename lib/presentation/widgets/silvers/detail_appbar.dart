import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/core/framework/globals.dart';
import 'package:realitart/presentation/views/AR/arview.dart';
import 'package:realitart/presentation/widgets/buttons.dart';

class DetailAppBar extends StatefulWidget {
  final String imgPath;
  final bool? btnAr;
  final int? assetId;
  const DetailAppBar(
      {Key? key, required this.imgPath, this.btnAr, this.assetId})
      : super(key: key);

  @override
  State<DetailAppBar> createState() => _DetailAppBarState();
}

class _DetailAppBarState extends State<DetailAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        expandedHeight: MediaQuery.of(context).size.height * 0.6,
        backgroundColor: const Color(0xFFE5E5E5),
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
        leadingWidth: MediaQuery.of(context).size.width,
        leading: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 4.0),
            child: Row(
              children: [
                FittedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(56.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: grey1.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                widget.btnAr != null && widget.btnAr == true
                    ? AppButton(
                        icono: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SvgPicture.asset(
                            'assets/svg/ar_icon.svg',
                            color: Colors.white,
                            width: 25,
                          ),
                        ),
                        label: 'Ver en AR',
                        radius: 10,
                        txtSize: 17,
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.045,
                        onPressed: () async {
                          await getPermissions().then((value) {
                            widget.assetId != null
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ARSection(
                                              assetId: widget.assetId!,
                                            )))
                                : null;
                          });
                        },
                        textColor: Colors.white,
                        colorDefault: const Color(0xFF302DA6),
                      )
                    : const SizedBox(),
              ],
            )),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
              height: 30,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Container(
                height: 5,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  color: black1,
                  borderRadius: BorderRadius.circular(10),
                ),
              )),
        ));
  }
}
