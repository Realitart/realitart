import 'package:flutter/material.dart';
import 'package:realitart/core/framework/globals.dart';
import 'package:realitart/data/models/artwork_model.dart';
import 'package:realitart/presentation/views/works/work_detail.dart';

import '../../../core/framework/colors.dart';
import '../buttons.dart';

class ObraCard extends StatelessWidget {
  final ArtworkModel artwork;
  const ObraCard({super.key, required this.artwork});

  @override
  Widget build(BuildContext context) {
    return Card(
      //color with gradient
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 25),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.47,
        decoration: const BoxDecoration(color: Color(0xFFF9F9F9)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                artwork.images,
                height: MediaQuery.of(context).size.height * 0.16,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(artwork.categoryId.name,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: 'Lato_bold',
                          color: txtGrey,
                          fontSize: 14)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(artwork.name,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontFamily: 'Gilroy_bold',
                          color: black1,
                          fontSize: 16)),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: black1,
                        size: 20,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text('9.2',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Lato_bold',
                              color: txtGrey,
                              fontSize: 14)),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.035,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WorkDetailScreen(
                                  artwork: artwork,
                                ))),
                    child: const Text(
                      'Ver más',
                      style: TextStyle(
                          fontFamily: 'Lato_regular',
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3C38CF),
                          fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
