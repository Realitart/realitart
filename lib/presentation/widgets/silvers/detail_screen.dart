import 'package:flutter/material.dart';
import 'package:realitart/presentation/widgets/silvers/detail_appbar.dart';

class DetailScreen extends StatefulWidget {
  final String imgPath;
  final Widget content;
  const DetailScreen({Key? key, required this.imgPath, required this.content})
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
          DetailAppBar(imgPath: widget.imgPath),
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
