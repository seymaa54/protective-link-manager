import 'package:flutter/material.dart';
import 'package:flutter_ble_app/register_screen.dart';
import 'package:flutter_ble_app/splash_screen.dart';

import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      initialRoute: SplashScreen.routeName,
      routes: {
        //main.dart home 'da splası çağıryor zaten buna gerek yok
      //  SplashScreen.routeName:(context)=>SplashScreen(),
        LoginScreen.routeName:(context)=>LoginScreen(),
        RegisterScreen.routeName:(context)=>RegisterScreen(),
      },
      onGenerateRoute: (settings){
        switch(settings.name){
         case SplashScreen.routeName:
            return MaterialPageRoute(builder: (context)=>SplashScreen());
          case LoginScreen.routeName:
            return MaterialPageRoute(builder: (context)=>LoginScreen());
          case RegisterScreen.routeName:
            return MaterialPageRoute(builder: (context)=>RegisterScreen());
          default :return null;

        }
      },
    );
  }
}
