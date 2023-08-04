import 'package:flutter/material.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/core/framework/globals.dart';
import 'package:realitart/presentation/widgets/cards/museos_card.dart';
import 'package:realitart/presentation/widgets/screenBase/screen_base.dart';

import '../../widgets/cards/new_obra_card.dart';
import '../../widgets/cards/obra_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const Text('Bienvenido a\nRealitart',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'Gilroy_bold',
                    color: Colors.black,
                    fontSize: 26)),
          ),
          recomendaciones(context),
          nuevosMuseos(context),
          const SizedBox(
            height: 20,
          ),
          nuevasObras(context),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  recomendaciones(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recomendaciones',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'Gilroy_bold', color: black1, fontSize: 20)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.34,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ObraCard(
                    imgPath: generateRandomImgUrl(),
                    title: generateRandomLoremIpsum(25),
                    description: generateRandomLoremIpsum(50),
                  );
                }),
          )
        ],
      ),
    );
  }

  nuevosMuseos(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nuevos Museos',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'Gilroy_bold', color: black1, fontSize: 20)),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.34,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return MuseoCard(
                    imgPath: generateRandomImgUrl(),
                    title: generateRandomLoremIpsum(45),
                    description: generateRandomLoremIpsum(10),
                  );
                }),
          )
        ],
      ),
    );
  }

  nuevasObras(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nuevas Obras',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'Gilroy_bold', color: black1, fontSize: 20)),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.34,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return NewObraCard(
                    imgPath: generateRandomImgUrl(),
                    title: generateRandomLoremIpsum(45),
                    description: generateRandomLoremIpsum(10),
                  );
                }),
          )
        ],
      ),
    );
  }
}
