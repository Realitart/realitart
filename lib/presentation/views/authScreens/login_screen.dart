import 'package:flutter/material.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/presentation/widgets/txt_custom_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTxt = TextEditingController();
  TextEditingController passwordTxt = TextEditingController();

  @override
  void dispose() {
    emailTxt.dispose();
    passwordTxt.dispose();
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
                  color: Colors.black, size: 20),
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Image.asset('assets/imgs/logo.png',
                  width: MediaQuery.of(context).size.width * 0.8),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: const Text('Bienvenido de vuelta',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Gilroy_bold',
                        color: Colors.black,
                        fontSize: 26)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: const Text('Iniciar sesión',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Gilroy_bold',
                        color: Colors.black,
                        fontSize: 20)),
              ),
              loginForm(),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/recoverPassword');
                      },
                      child: const Text('¿Olvidaste tu contraseña?',
                          style: TextStyle(
                              fontFamily: 'Lato',
                              color: Colors.black,
                              fontSize: 16))),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, '/init');
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  color: black1,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 20),
                  child: const Text('Iniciar sesión',
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
              controller: emailTxt,
              leftIcon: Icons.email_rounded,
              keyboardType: TextInputType.emailAddress,
              labelText: 'Correo electrónico',
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'El email no puede estar vacio';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: passwordTxt,
              labelText: 'Contraseña',
              keyboardType: TextInputType.visiblePassword,
              leftIcon: Icons.lock_rounded,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'La contraseña no puede estar vacia';
                }
                return null;
              },
              rightIcon: Icons.visibility,
            ),
          ],
        ),
      ),
    );
  }
}
