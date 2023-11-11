import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realitart/core/framework/colors.dart';
import 'package:realitart/core/framework/globals.dart';
import 'package:realitart/core/routes.dart';

bool? _isLoggedIn;
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    //Traer paths desde firebase
    _isLoggedIn = await getPreference('user') != null;

    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Realitart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // fontFamily: 'Gilroy_light',
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: txtBlack)),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: basicColors)
              .copyWith(background: Colors.white)),
      initialRoute: _isLoggedIn ?? false ? '/home' : '/first',
      // initialRoute: '/first',
      routes: routes,
    );
  }
}
