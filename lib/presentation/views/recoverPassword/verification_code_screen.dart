import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/presentation/widgets/txt_custom_form.dart';

class VerificationCode extends StatefulWidget {
  const VerificationCode({super.key});

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  final formKey = GlobalKey<FormState>();
  bool pinFail = false;
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: grey1, borderRadius: BorderRadius.circular(15)),
              child: const Icon(Icons.arrow_back_ios_new,
                  color: txtBlack, size: 20),
            ),
          )),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              AppBar().preferredSize.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              const Center(
                child: Text('Código de Verificación',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Gilroy_bold',
                        color: txtBlack,
                        fontSize: 26)),
              ),
              SvgPicture.asset('assets/svg/lock_cloud.svg',
                  width: MediaQuery.of(context).size.width * 0.8),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              codeForm(),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.only(bottom: 60),
                  child: GestureDetector(
                      onTap: () {},
                      child: const Text(
                          'Introduce el código enviado a /n usuario@gmail.com',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Lato_regular',
                              color: txtGrey,
                              fontSize: 13))),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/newPassword');
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  color: black1,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 20),
                  child: const Text('Confirmar Correo',
                      style: TextStyle(
                          fontFamily: 'Gilroy_bold',
                          color: Colors.white,
                          fontSize: 20)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget codeForm() {
    var focusedBorderColor = black1;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = black1;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontFamily: 'letra_Telefonica_regular',
        fontSize: 18,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return Pinput(
      length: 4,
      controller: pinController,
      focusNode: focusNode,
      closeKeyboardWhenCompleted: true,
      defaultPinTheme: defaultPinTheme,
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      forceErrorState: pinFail,
      errorText: 'Código inválido',
      errorTextStyle: const TextStyle(
        fontFamily: 'letra_Telefonica_bold',
        fontSize: 16,
        color: Colors.red,
      ),
      onChanged: (value) {
        debugPrint('onChanged: $value');
      },
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 9),
            width: 22,
            height: 1,
            color: focusedBorderColor,
          ),
        ],
      ),
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: focusedBorderColor),
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          color: fillColor,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: focusedBorderColor),
        ),
      ),
      errorPinTheme: defaultPinTheme.copyBorderWith(
        border: Border.all(color: Colors.redAccent),
      ),
    );
  }
}
