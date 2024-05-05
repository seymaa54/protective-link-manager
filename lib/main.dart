import 'package:flutter/material.dart';
import 'package:protective_link_manager/register_screen.dart';
import 'login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: const LoginScreen(),
      initialRoute: LoginScreen.routeName,
      routes: {
        //main.dart home 'da splası çağıryor zaten buna gerek yok
      //  SplashScreen.routeName:(context)=>SplashScreen(),
        LoginScreen.routeName:(context)=>LoginScreen(),
        RegisterScreen.routeName:(context)=>RegisterScreen(),
      },
      onGenerateRoute: (settings){
        switch(settings.name){
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
