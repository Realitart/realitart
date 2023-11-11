import 'package:flutter/material.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/presentation/widgets/buttons.dart';

class InfoDialog extends StatelessWidget {
  final String title, message;
  final Function() onPressed;
  Widget? icon, content;
  bool? closeOption = false;
  InfoDialog(
      {Key? key,
      required this.title,
      required this.message,
      this.icon,
      this.content,
      required this.onPressed,
      this.closeOption})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                icon ?? Container(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontFamily: 'Gilroy_bold', fontSize: 20, color: txtBlack),
                ),
                const SizedBox(
                  height: 10,
                ),
                content ?? Container(),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    message,
                    style: const TextStyle(
                        fontFamily: 'Gilroy_semibold',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: txtBlack),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    closeOption ?? false
                        ? AppButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            label: 'Cancelar',
                            colorDefault: grey1,
                            textColor: Colors.grey,
                            width: MediaQuery.of(context).size.width * 0.5,
                          )
                        : const SizedBox(),
                    closeOption ?? false
                        ? const SizedBox(
                            width: 15,
                          )
                        : const SizedBox(),
                    AppButton(
                      onPressed: onPressed,
                      label: 'Continuar',
                      colorDefault: const Color(0xFF302DA6),
                      textColor: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
