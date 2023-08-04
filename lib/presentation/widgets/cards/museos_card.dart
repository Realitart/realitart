import 'package:flutter/material.dart';
import 'package:realitart/presentation/views/museums/museum_detail.dart';

import '../../../core/framework/colors.dart';

class MuseoCard extends StatelessWidget {
  final String imgPath, title, description;
  const MuseoCard({
    super.key,
    required this.imgPath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      //color with gradient
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              child: Image.network(
                imgPath,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.22,
                fit: BoxFit.fill,
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width * 0.55,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Text(title,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        style: const TextStyle(
                            fontFamily: 'Gilroy_bold',
                            color: black1,
                            fontSize: 16)),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.03,
                    child: Text(description,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontFamily: 'Lato_regular',
                            color: txtGrey,
                            fontSize: 14)),
                  ),
                ],
              ),
            ),
            //Icon button square with radius
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MuseumDetailScreen())),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.075,
                  height: MediaQuery.of(context).size.width * 0.075,
                  margin: const EdgeInsets.only(right: 10, bottom: 15),
                  decoration: const BoxDecoration(
                    color: btnGrey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                    color: black1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
