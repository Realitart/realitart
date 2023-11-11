import 'package:flutter/material.dart';
import 'package:realitart/core/framework/colors.dart';

// ignore: must_be_immutable
class ErrorAlertDialog extends StatelessWidget {
  final String errorMessage;
  Function func_back;
  ErrorAlertDialog(
      {Key? key, required this.errorMessage, required this.func_back})
      : super(key: key);

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
                Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.15,
                  //circle
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width * 0.12,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: txtBlack),
                  ),
                ),
                const SizedBox(height: 20),
                button("Volver", () {
                  Navigator.of(context).pop();
                  func_back();
                }, black1),
              ],
            ),
          ),
        ));
  }

  Widget button(String text, Function press, Color color) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 30),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      onPressed: () async {
        press();
      },
    );
  }
}
