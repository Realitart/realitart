import 'package:flutter/material.dart';
import 'package:realitart/data/services/auth_service.dart';

import '../../../../core/framework/colors.dart';

class CommentContainer extends StatefulWidget {
  final String date, comment;
  final int userId;
  const CommentContainer({
    super.key,
    required this.userId,
    required this.date,
    required this.comment,
  });

  @override
  State<CommentContainer> createState() => _CommentContainerState();
}

class _CommentContainerState extends State<CommentContainer> {
  String? name, imgPath;
  getUserName() {
    AuthService()
        .getUser(widget.userId.toString())
        .then((value) => setState(() {
              name = value!.name;
            }));
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.only(left: 5, bottom: 10, top: 10),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      "https://cdn-icons-png.flaticon.com/512/666/666201.png",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    child: Text(
                      name ?? 'Username',
                      style: const TextStyle(
                          fontFamily: 'Gilroy_bold',
                          fontSize: 16,
                          color: txtBlack),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.date,
                    style: const TextStyle(
                        fontFamily: 'Gilroy_regular',
                        fontSize: 12,
                        color: txtGrey),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                //widht of Card
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  widget.comment,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontFamily: 'Gilroy_regular',
                      fontSize: 14,
                      color: txtGrey),
                ),
              ),
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
                      const PopupMenuItem(
                        value: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Editar'),
                            Icon(Icons.edit, color: txtGrey),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
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
    );
  }
}
