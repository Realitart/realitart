import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/core/framework/globals.dart';
import 'package:realitart/data/models/user_model.dart';

class LateralDrawer extends StatefulWidget {
  const LateralDrawer({Key? key}) : super(key: key);

  @override
  State<LateralDrawer> createState() => _LateralDrawerState();
}

class _LateralDrawerState extends State<LateralDrawer> {
  //List of Map<String, String> with the menu options

  bool loading = false;
  UserModel? user;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    String userData = await getPreference('user');
    var userJson = json.decode(userData);
    setState(() {
      user = UserModel.fromJson(userJson);
    });
  }

  @override
  Widget build(BuildContext context) {
    //lateral bar drawer with user data and list menus
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      backgroundColor: Colors.white,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Stack(children: [
              Container(
                //img background
                height: MediaQuery.of(context).size.height * 0.22,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/imgs/FondoPatron.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.width * 0.15,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top + 30,
                    left: MediaQuery.of(context).size.width * 0.05),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: ClipOval(
                  child: loading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Image.network(
                          "https://cdn-icons-png.flaticon.com/512/666/666201.png",
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top + 100),
                alignment: Alignment.centerLeft,
                child: Text(
                  loading ? 'Cargando...' : user?.email ?? 'Username',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Lato_bold',
                      fontWeight: FontWeight.w700),
                ),
              ),
            ]),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            btnimageTxt('assets/svg/home_icon.svg', 'Inicio',
                () => Navigator.pushNamed(context, '/home')),
            btnimageTxt('assets/svg/museum_icon.svg', 'Museos',
                () => Navigator.pushNamed(context, '/museums')),
            btnimageTxt('assets/svg/obras_icon.svg', 'Obras',
                () => Navigator.pushNamed(context, '/works')),
            btnimageTxt('assets/svg/test_icon.svg', 'Test',
                () => Navigator.pushNamed(context, '/tests')),
            const Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      title: const Text(
                        'Cerrar Sesión',
                        style: TextStyle(
                            color: txtBlack,
                            fontSize: 18,
                            fontFamily: 'Gilroy_semibold',
                            fontWeight: FontWeight.w700),
                      ),
                      content: const Text(
                        '¿Estás seguro que deseas cerrar sesión?',
                        style: TextStyle(
                            color: txtBlack,
                            fontSize: 16,
                            fontFamily: 'Gilroy_semibold',
                            fontWeight: FontWeight.w700),
                      ),
                      // actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: txtBlack.withOpacity(0.25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gilroy_semibold',
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF302DA6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            cleanPreference();
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/first', (route) => false);
                          },
                          child: const Text(
                            'Aceptar',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gilroy_semibold',
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 1),
                          child: SvgPicture.asset('assets/svg/logout_icon.svg',
                              height: MediaQuery.of(context).size.height * 0.03,
                              color: black1),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Cerrar Sesión',
                            style: TextStyle(
                                color: txtBlack,
                                fontSize: 18,
                                fontFamily: 'Gilroy_light',
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Versión 1.0.0',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: txtBlack,
                          fontSize: 12,
                          fontFamily: 'Gilroy_light',
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).viewPadding.bottom + 10,
            ),
          ],
        ),
      ),
    );
  }

  btnimageTxt(String iconPath, String txt, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: SvgPicture.asset(
                iconPath,
                height: MediaQuery.of(context).size.height * 0.045,
                color: black1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13.0),
              child: Text(
                txt,
                style: const TextStyle(
                    color: txtBlack,
                    fontSize: 18,
                    fontFamily: 'Gilroy_light',
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
