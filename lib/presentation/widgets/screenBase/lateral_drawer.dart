import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realitart/core/framework/colors.dart';

class LateralDrawer extends StatefulWidget {
  const LateralDrawer({Key? key}) : super(key: key);

  @override
  State<LateralDrawer> createState() => _LateralDrawerState();
}

class _LateralDrawerState extends State<LateralDrawer> {
  //List of Map<String, String> with the menu options

  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //lateral bar drawer with user data and list menus
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.6,
      backgroundColor: Colors.white,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).viewPadding.top + 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.width * 0.35,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: black1,
              ),
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: black1,
                      ),
                    )
                  : Image.asset('assets/imgs/logo.png'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                loading ? 'Cargando...' : 'Uasername',
                style: const TextStyle(
                    color: txtBlack,
                    fontSize: 24,
                    fontFamily: 'Gilroy_semibold',
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            btnimageTxt('assets/svg/home_icon.svg', 'Inicio', () => null),
            btnimageTxt('assets/svg/profile_icon.svg', 'Perfil', () => null),
            btnimageTxt('assets/svg/museum_icon.svg', 'Museos', () => null),
            btnimageTxt('assets/svg/obras_icon.svg', 'Obras', () => null),
            btnimageTxt('assets/svg/test_icon.svg', 'Test', () => null),
            const Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
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
                            fontSize: 24,
                            fontFamily: 'Gilroy_semibold',
                            fontWeight: FontWeight.w700),
                      ),
                      content: const Text(
                        '¿Estás seguro que deseas cerrar sesión?',
                        style: TextStyle(
                            color: txtBlack,
                            fontSize: 24,
                            fontFamily: 'Gilroy_semibold',
                            fontWeight: FontWeight.w700),
                      ),
                      // actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.25),
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
                                color: txtBlack,
                                fontSize: 24,
                                fontFamily: 'Gilroy_semibold',
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: black1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            // BlocProvider.of<UserBloc>(context, listen: false)
                            //     .add(UserLogOutEvent());
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/login', (route) => false);
                          },
                          child: const Text(
                            'Aceptar',
                            style: TextStyle(
                                color: txtBlack,
                                fontSize: 24,
                                fontFamily: 'Gilroy_semibold',
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 1),
                      child: SvgPicture.asset(
                        'assets/svg/logout_icon.svg',
                        height: MediaQuery.of(context).size.height * 0.033,
                        color: black1,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Cerrar Sesión',
                        style: TextStyle(
                            color: txtBlack,
                            fontSize: 22,
                            fontFamily: 'Gilroy_light',
                            fontWeight: FontWeight.w700),
                      ),
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
