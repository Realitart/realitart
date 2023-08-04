import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/presentation/widgets/txt_custom_form.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final formKey = GlobalKey<FormState>();
  TextEditingController passwordTxt = TextEditingController();
  TextEditingController repasswordTxt = TextEditingController();
  @override
  void dispose() {
    passwordTxt.dispose();
    repasswordTxt.dispose();
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
                child: Text('Nueva contraseña',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Gilroy_bold',
                        color: txtBlack,
                        fontSize: 26)),
              ),
              SvgPicture.asset('assets/svg/lock_cloud.svg',
                  width: MediaQuery.of(context).size.width * 0.8),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              loginForm(),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.only(bottom: 60),
                  child: GestureDetector(
                      onTap: () {},
                      child: const Text('Escribe tu nueva contraseña',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Lato_regular',
                              color: txtGrey,
                              fontSize: 13))),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, '/verificationCode');
                  }
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

  loginForm() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFormField(
              controller: passwordTxt,
              labelText: 'Contraseña',
              keyboardType: TextInputType.visiblePassword,
              leftIcon: Icons.lock_rounded,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Contraseña no puede estar vacia';
                }
                return null;
              },
              rightIcon: Icons.visibility,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            CustomTextFormField(
              controller: repasswordTxt,
              labelText: 'Confirma tu contraseña',
              keyboardType: TextInputType.visiblePassword,
              leftIcon: Icons.lock_rounded,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Contraseña no puede estar vacia';
                } else if (p0 != passwordTxt.text) {
                  return 'Las contraseñas no coinciden';
                }
              },
              rightIcon: Icons.visibility,
            ),
          ],
        ),
      ),
    );
  }
}
