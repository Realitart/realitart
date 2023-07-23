import 'package:flutter/material.dart';
import 'package:realitart/presentation/widgets/circlularimg.dart';
import 'package:realitart/presentation/widgets/screenBase/screen_base.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/imgs/logo.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const Text(
            'Bienvenido',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
