import 'package:flutter/material.dart';
import 'package:realitart/presentation/widgets/silvers/detail_appbar.dart';

class DetailScreen extends StatefulWidget {
  final String imgPath;
  final int? assetId;
  final Widget content;
  final bool? btnAr;
  const DetailScreen(
      {Key? key,
      required this.imgPath,
      required this.content,
      this.assetId,
      this.btnAr})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          DetailAppBar(
              btnAr: widget.btnAr,
              assetId: widget.assetId,
              imgPath: widget.imgPath),
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: widget.content,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
