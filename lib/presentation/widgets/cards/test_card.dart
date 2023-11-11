import 'package:flutter/material.dart';
import 'package:realitart/core/framework/globals.dart';
import 'package:realitart/presentation/views/test/test_detail.dart';

import '../../../core/framework/colors.dart';

class TestCard extends StatelessWidget {
  final String qualification, title, date;
  const TestCard({
    super.key,
    required this.qualification,
    required this.title,
    required this.date,
  });

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
            Container(
              color: const Color(0xFFE8ECFC),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.3,
              child: Icon(
                Icons.check_circle_rounded,
                color: Colors.white.withOpacity(0.85),
                size: 70,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: const TextStyle(
                          fontFamily: 'Gilroy_bold',
                          color: black1,
                          fontSize: 16)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("$qualification de 20",
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: const TextStyle(
                          fontFamily: 'Lato_regular',
                          color: black1,
                          fontSize: 16)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(formatDateToTxt(date.substring(0, 10)),
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: 'Lato_regular',
                          color: txtGrey,
                          fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
