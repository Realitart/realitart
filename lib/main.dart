import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/core/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String initialRoute = '';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Para que la app no rote
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Realitart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // fontFamily: 'Gilroy_light',
          scaffoldBackgroundColor: const Color(0xFFF3F8F9),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: txtBlack)),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: basicColors)
              .copyWith(background: const Color(0xFFF3F8F9))),
      // initialRoute: '/first',
      initialRoute: '/works',
      routes: routes,
    );
  }
}
