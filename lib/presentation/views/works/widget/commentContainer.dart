import 'package:flutter/material.dart';

import '../../../../core/framework/colors.dart';

class CommentContainer extends StatelessWidget {
  final String imgPath, name, date, comment;
  const CommentContainer({
    super.key,
    required this.imgPath,
    required this.name,
    required this.date,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.only(right: 10, left: 10, bottom: 20),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.only(left: 5, bottom: 10, top: 10),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(imgPath),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      //widht of Card
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        name,
                        style: const TextStyle(
                            fontFamily: 'Gilroy_bold',
                            fontSize: 16,
                            color: txtBlack),
                      ),
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                          fontFamily: 'Gilroy_regular',
                          fontSize: 12,
                          color: txtGrey),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                      //widht of Card
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        comment,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontFamily: 'Gilroy_regular',
                            fontSize: 14,
                            color: txtGrey),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Positioned(
              right: -4,
              top: -10,
              child: PopupMenuButton(
                  icon: const Icon(Icons.more_vert, color: txtGrey),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onSelected: (val) => {print(val)},
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
                              Text('Editar'),
                              Icon(Icons.edit, color: txtGrey),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
                              Text('Eliminar'),
                              Icon(
                                Icons.delete,
                                color: txtGrey,
                              ),
                            ],
                          ),
                        ),
                      ]),
            )
          ],
        ),
      ),
    );
  }
}
