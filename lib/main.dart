import 'package:flutter/material.dart';
import 'package:social_media/auth/login.dart';
import 'package:social_media/auth/register.dart';
import 'package:social_media/constants/theme.dart';
import 'package:social_media/screen/bottom_nav.dart';
import 'package:social_media/screen/home_screen.dart';
import 'package:social_media/screen/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Constants.darkTheme,
      routes: {
        '/': (context) => const RegisterScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        BottomNavigationScreen.routeName: (context) => const BottomNavigationScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        ProfileScreen.routeName: (context) => ProfileScreen(),
      },
    );
  }
}
