import 'package:flutter/material.dart';
import 'package:realitart/data/models/artwork_model.dart';
import 'package:realitart/presentation/views/works/work_detail.dart';

import '../../../core/framework/colors.dart';

class NewObraCard extends StatelessWidget {
  final ArtworkModel artwork;
  const NewObraCard({super.key, required this.artwork});

  @override
  Widget build(BuildContext context) {
    return Card(
      //color with gradient
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: const BoxDecoration(
          color: Color(0xFFF9F9F9),
        ),
        child: Row(
          children: [
            Image.network(
              artwork.images,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.3,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(artwork.categoryId.name,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: 'Lato_regular',
                          color: txtGrey,
                          fontSize: 14)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(artwork.name,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                  const Spacer(),
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
