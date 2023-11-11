import 'package:flutter/material.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/data/models/auth_model.dart';
import 'package:realitart/data/models/user_model.dart';
import 'package:realitart/data/services/auth_service.dart';
import 'package:realitart/presentation/widgets/dialogs/erro_alert_dialog.dart';
import 'package:realitart/presentation/widgets/radio_buttons.dart';
import 'package:realitart/presentation/widgets/txt_custom_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTxt = TextEditingController();
  TextEditingController nameTxt = TextEditingController();
  TextEditingController usernameTxt = TextEditingController();
  TextEditingController passwordTxt = TextEditingController();
  bool registerloading = false;
  late String userType;
  @override
  void dispose() {
    // TODO: implement dispose
    emailTxt.dispose();
    passwordTxt.dispose();
    nameTxt.dispose();
    usernameTxt.dispose();
    super.dispose();
  }

  showErrorDialog() {
    setState(() {
      registerloading = false;
    });
    return showDialog(
        context: context,
        builder: ErrorAlertDialog(
          func_back: () {},
          errorMessage: 'Error al registrar usuario',
        ).build);
  }

  void register() {
    setState(() {
      registerloading = true;
    });
    AuthModel authModel = AuthModel(
      username: usernameTxt.text,
      password: passwordTxt.text,
    );
    UserModel userModel = UserModel(
      email: emailTxt.text,
      name: nameTxt.text,
      username: usernameTxt.text,
      password: passwordTxt.text,
      activeNotifications: true,
      imageId: 1,
      id: 0,
      idUserType: userType == 'Profesor' ? 2 : 3,
    );
    AuthService().register(authModel).then((value) {
      if (value) {
        AuthService().createUser(userModel).then((value) {
          if (value) {
            Navigator.pushNamed(context, '/home');
          } else {
            showErrorDialog();
          }
        });
      } else {
        showErrorDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/first');
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Image.asset('assets/imgs/logo.png',
                        width: MediaQuery.of(context).size.width * 0.3),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Text('Explora el arte sin límites',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Gilroy_bold',
                              color: Color(0xFF302DA6),
                              fontSize: 26)),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Text('Registrate',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Gilroy_bold',
                              color: Color(0xFF302DA6),
                              fontSize: 20)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Expanded(
                child: registerForm(),
              ),
              // Expanded(child: Container()),
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    register();
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0xFF302DA6),
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 20),
                  child: registerloading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Registrate',
                          style: TextStyle(
                              fontFamily: 'Gilroy_bold',
                              color: Colors.white,
                              fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  registerForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomRadioButtons(
                  options: const ['Profesor', 'Estudiante'],
                  isVertical: false,
                  onChanged: (value) {
                    setState(() {
                      userType = value;
                    });
                  }),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: nameTxt,
                leftIcon: Icons.person_rounded,
                labelText: 'Nombre',
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return 'Nombre no puede estar vacio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: usernameTxt,
                leftIcon: Icons.person_rounded,
                labelText: 'Username',
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return 'Username no puede estar vacio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: emailTxt,
                leftIcon: Icons.email_rounded,
                keyboardType: TextInputType.emailAddress,
                labelText: 'Correo electrónico',
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return 'Email no puede estar vacio';
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
                    return 'Contraseña no puede estar vacia';
                  }
                  return null;
                },
                rightIcon: Icons.visibility,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
