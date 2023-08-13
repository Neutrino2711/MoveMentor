import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:status_code0/models/google_signin.dart';
import 'package:status_code0/screens/activity.dart';
import 'package:status_code0/screens/nav_controller_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:status_code0/screens/rewards.dart';
import 'package:status_code0/screens/signin_screen.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 0, 0));

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onBackground,
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w800
                        // fontSize: 30.0,
                        ),
                bodyLarge: TextStyle(
                  color: Colors.white,
                ),
              ),
        ),
        home: LoginPage(),
        // home: HomePage(
        //   sleep_: "00",
        //   steps_: "00",
        //   water_: "00",
        //   weight_: 00,
        // ),
        // themeMode: ThemeMode.dark,
      ));
}
