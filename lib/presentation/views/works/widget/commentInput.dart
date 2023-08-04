import 'package:flutter/material.dart';
import 'package:realitart/presentation/widgets/buttons.dart';
import 'package:realitart/presentation/widgets/txt_custom_form.dart';

import '../../../../core/framework/colors.dart';

class CommentInput extends StatelessWidget {
  final String imgPath;
  const CommentInput({super.key, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    TextEditingController txtCommentController = TextEditingController();
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      // margin: const EdgeInsets.only(right: 10, left: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.only(left: 5, bottom: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(imgPath),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.64,
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
              child: AppButton(
                label: 'Publicar',
                txtSize: 17,
                textColor: txtBlack,
                colorDefault: btnGreyBold,
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.22,
                radius: 10,
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
