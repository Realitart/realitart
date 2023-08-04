import 'package:flutter/material.dart';
import 'package:realitart/presentation/views/works/work_detail.dart';

import '../../../core/framework/colors.dart';
import '../buttons.dart';

class ObraCard extends StatelessWidget {
  final String imgPath, title, description;
  const ObraCard({
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
      elevation: 10,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 25),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.white,
              Color(0xFFE7E8EA),
              Color(0xFFE7E8EA),
              Color(0xFFE7E8EA),
            ],
          ),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                imgPath,
                height: MediaQuery.of(context).size.height * 0.12,
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
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Text(title,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontFamily: 'Gilroy_bold',
                            color: black1,
                            fontSize: 16)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Text(description,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontFamily: 'Lato_regular',
                            color: txtGrey,
                            fontSize: 13)),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  color: black1,
                  size: 16,
                ),
                const SizedBox(
                  width: 2,
                ),
                const Text('9.2',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Lato_regular',
                        color: txtGrey,
                        fontSize: 13)),
                const SizedBox(
                  width: 8,
                ),
                AppButton(
                  label: 'Ver',
                  radius: 10,
                  txtSize: 17,
                  width: MediaQuery.of(context).size.width * 0.16,
                  height: MediaQuery.of(context).size.height * 0.04,
                  onPressed: () {
                    //Navigate to WorkDetail()
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WorkDetailScreen()));
                  },
                  textColor: txtBlack,
                  colorDefault: Colors.white,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
