import 'package:flutter/material.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/core/framework/globals.dart';
import 'package:realitart/data/models/auth_model.dart';
import 'package:realitart/data/services/auth_service.dart';
import 'package:realitart/presentation/widgets/dialogs/erro_alert_dialog.dart';
import 'package:realitart/presentation/widgets/txt_custom_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameTxt = TextEditingController();
  TextEditingController passwordTxt = TextEditingController();
  bool loginloading = false;
  @override
  void dispose() {
    usernameTxt.dispose();
    passwordTxt.dispose();
    super.dispose();
  }

  showErrorDialog() {
    setState(() {
      loginloading = false;
    });
    return showDialog(
        context: context,
        builder: ErrorAlertDialog(
          func_back: () {},
          errorMessage: 'Error al iniciar sesión',
        ).build);
  }

  login() {
    AuthModel authRequest = AuthModel(
      username: usernameTxt.text,
      password: passwordTxt.text,
    );
    AuthService().login(authRequest).then((value) {
      if (value) {
        setState(() {
          loginloading = false;
        });
        Navigator.pushNamed(context, '/home');
      } else {
        showErrorDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/imgs/FondoPatron.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      top: MediaQuery.of(context)
                          .viewPadding
                          .top, // Ajustar la posición vertical
                      left: 5, // Ajustar la posición horizontal
                      child: GestureDetector(
                        onTap: () {
                          // Ir a la pantalla anterior
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Icon(Icons.arrow_back_ios_new,
                              color: Colors.black, size: 20),
                        ),
                      ),
                    ),
                    // Otro contenido debajo si es necesario
                  ],
                ),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              const Spacer(),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: const Text('Empecemos!',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Gilroy_bold',
                        color: Color(0xFF302DA6),
                        fontSize: 26)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: const Text('Iniciar sesión',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Gilroy_bold',
                        color: Color(0xFF302DA6),
                        fontSize: 20)),
              ),
              const Spacer(),

              loginForm(),
              const Spacer(),
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/recoverPassword');
                    },
                    child: const Text('¿Olvidaste tu contraseña?',
                        style: TextStyle(
                            fontFamily: 'Lato_regular',
                            color: txtBlack,
                            fontSize: 16))),
              ),
              GestureDetector(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    await getPermissions().then((value) {
                      login();
                    });
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0xFF302DA6),
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 20),
                  child: loginloading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Iniciar sesión',
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
              controller: usernameTxt,
              leftIcon: Icons.person_rounded,
              keyboardType: TextInputType.name,
              labelText: 'Username',
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'El username no puede estar vacio';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              controller: passwordTxt,
              keyboardType: TextInputType.visiblePassword,
              leftIcon: Icons.lock_rounded,
              labelText: 'Contraseña',
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
