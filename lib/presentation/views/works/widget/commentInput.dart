import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:realitart/core/framework/globals.dart';
import 'package:realitart/data/models/create_comment_model.dart';
import 'package:realitart/data/models/user_model.dart';
import 'package:realitart/data/services/musseum_works_service.dart';
import 'package:realitart/presentation/widgets/buttons.dart';
import 'package:realitart/presentation/widgets/dialogs/erro_alert_dialog.dart';
import 'package:realitart/presentation/widgets/txt_custom_form.dart';

import '../../../../core/framework/colors.dart';

class CommentInput extends StatefulWidget {
  final String imgPath;
  final int artworkId;
  final Function? func;
  const CommentInput(
      {super.key, required this.imgPath, required this.artworkId, this.func});

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  TextEditingController txtCommentController = TextEditingController();
  bool loadingPost = false;
  postComment() async {
    setState(() {
      loadingPost = true;
    });
    String userData = await getPreference('user');
    var userJson = json.decode(userData);
    UserModel user = UserModel.fromJson(userJson);
    MuseumWorkService()
        .createComment(CreateCommentModel(
            description: txtCommentController.text,
            userId: user.id,
            artworkId: widget.artworkId))
        .then((value) {
      if (value) {
        setState(() {
          loadingPost = false;
        });
        txtCommentController.clear();
        widget.func!();
      } else {
        setState(() {
          loadingPost = false;
        });
        return showDialog(
            context: context,
            builder: ErrorAlertDialog(
              func_back: () {},
              errorMessage: 'Error al publicar comentario',
            ).build);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.only(left: 5, bottom: 0, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.81,
                height: MediaQuery.of(context).size.height * 0.15,
                child: CustomTextFormField(
                  maxLines: 4,
                  fillColor: Colors.transparent,
                  borderColor: txtGrey,
                  controller: txtCommentController,
                  validator: (value) => null,
                  hintText: 'Escribe un comentario',
                ),
              ),
            ],
          ),
          //Publicar button
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: loadingPost
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : AppButton(
                    label: 'Comentar',
                    txtSize: 17,
                    textColor: Colors.white,
                    colorDefault: const Color(0xFF302DA6),
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.3,
                    radius: 100,
                    onPressed: () {
                      postComment();
                    },
                  ),
          )
        ],
      ),
    );
  }
}
