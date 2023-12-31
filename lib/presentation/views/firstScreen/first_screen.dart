import 'package:flutter/material.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/presentation/widgets/buttons.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/imgs/fondo_inicio.png'),
                  fit: BoxFit.cover,
                ),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/imgs/logo.png',
                    width: MediaQuery.of(context).size.width * 0.15),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: const Text('Comienza a explorar el arte sin límites',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Gilroy_bold',
                          color: txtBlack,
                          fontSize: 22)),
                ),
                AppButton(
                    label: 'Ingreso',
                    colorDefault: const Color(0xFF302DA6),
                    width: MediaQuery.of(context).size.width * 0.7,
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    }),
                AppButton(
                    label: 'Regístrate',
                    textColor: const Color(0xFF302DA6),
                    borderColorDefault: const Color(0xFF302DA6),
                    width: MediaQuery.of(context).size.width * 0.7,
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    }),
                const SizedBox(height: 15),
              ],
            ),
          )
        ],
      ),
    );
  }
}
