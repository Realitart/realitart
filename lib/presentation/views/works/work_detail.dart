import 'package:flutter/material.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/core/framework/globals.dart';
import 'package:realitart/presentation/views/works/widget/commentContainer.dart';
import 'package:realitart/presentation/views/works/widget/commentInput.dart';
import 'package:realitart/presentation/widgets/silvers/detail_screen.dart';

class WorkDetailScreen extends StatelessWidget {
  const WorkDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DetailScreen(
      imgPath: generateRandomImgUrl(),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            generateRandomLoremIpsum(10),
            style: const TextStyle(
                fontFamily: 'Gilroy_bold', fontSize: 24, color: txtBlack),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            generateRandomLoremIpsum(20),
            style: const TextStyle(
                fontFamily: 'Gilroy_regular', fontSize: 14, color: txtGrey),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            generateRandomLoremIpsum(40),
            style: const TextStyle(
                fontFamily: 'Gilroy_regular', fontSize: 14, color: txtGrey),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            generateRandomLoremIpsum(400),
            style: const TextStyle(
              fontFamily: 'Gilroy_regular',
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text('Comentarios',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'Gilroy_bold', color: black1, fontSize: 20)),
          CommentInput(imgPath: generateRandomImgUrl()),
          ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CommentContainer(
                  imgPath: generateRandomImgUrl(),
                  name: generateRandomLoremIpsum(10),
                  date: '20/03/2023 07:30 PM',
                  comment: generateRandomLoremIpsum(70),
                );
              }),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    ));
  }
}
