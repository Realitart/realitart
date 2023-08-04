import 'package:flutter/material.dart';
import 'package:realitart/core/framework/colors.dart';
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
  @override
  void dispose() {
    // TODO: implement dispose
    emailTxt.dispose();
    passwordTxt.dispose();
    nameTxt.dispose();
    usernameTxt.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Image.asset('assets/imgs/logo.png',
                        width: MediaQuery.of(context).size.width * 0.7),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Text('Explora el arte sin límites',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Gilroy_bold',
                              color: txtBlack,
                              fontSize: 26)),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Text('Registrate',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Gilroy_bold',
                              color: txtBlack,
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
                    print('Validado');
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  color: black1,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 20),
                  child: const Text('Registrate',
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
                  onChanged: (value) {}),
              const SizedBox(height: 10),
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
