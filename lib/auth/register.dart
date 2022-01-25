import 'package:flutter/material.dart';
import 'package:social_media/auth/login.dart';

import '../screen/bottom_nav.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/signup-screen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController? _nameTextController;
    TextEditingController? _emailTextController;
    TextEditingController? _passwordTextController;
    TextEditingController? _confirmPasswordTextController;

    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 25,
                bottom: 10,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                "Sign up",
                style: textTheme.headline2,
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 28,
                      top: 20,
                      bottom: 10,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Name',
                      style: textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: TextField(
                      keyboardType: TextInputType.name,
                      controller: _nameTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        filled: true,
                        hintStyle: const TextStyle(color: Colors.grey),
                        hintText: "Enter your name",
                        fillColor: const Color.fromRGBO(35, 31, 32, 1),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 28,
                      top: 12,
                      bottom: 10,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email',
                      style: textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: TextField(
                      controller: _emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        filled: true,
                        hintStyle: const TextStyle(color: Colors.grey),
                        hintText: "Enter your email",
                        fillColor: const Color.fromRGBO(35, 31, 32, 1),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 28,
                      top: 12,
                      bottom: 10,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password',
                      style: textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: TextField(
                      controller: _passwordTextController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        filled: true,
                        hintStyle: const TextStyle(color: Colors.grey),
                        hintText: "Pick a strong password",
                        fillColor: const Color.fromRGBO(35, 31, 32, 1),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 28,
                      top: 12,
                      bottom: 10,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Confirm Password',
                      style: textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: TextField(
                      controller: _confirmPasswordTextController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        focusColor: Colors.purple,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        filled: true,
                        hintStyle: const TextStyle(color: Colors.grey),
                        hintText: "Confirm your password",
                        fillColor: const Color.fromRGBO(35, 31, 32, 1),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 20,
                      right: 20,
                    ),
                    child: _createAccountButton(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(LoginScreen.routeName);
                            },
                            child: const Text(
                              'Log in',
                              style: TextStyle(
                                color: Color.fromRGBO(253, 254, 255, 1),
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

/// A button that shows a circular progress indicator when pressed.
/// The progress indicator is shown after a brief delay, and the button disappears.
/// The button is disabled while the progress indicator is shown.
Widget _createAccountButton(BuildContext context) {
  return RaisedButton(
    onPressed: () {
      Navigator.of(context).pushReplacementNamed(BottomNavigationScreen.routeName);
    },
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
    ),
    padding: const EdgeInsets.all(0.0),
    child: Ink(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Colors.purpleAccent, Colors.purple],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
      child: Container(
        height: 50,
        constraints: const BoxConstraints(
          minWidth: 88.0,
          minHeight: 36.0,
        ), // min sizes for Material buttons
        alignment: Alignment.center,
        child: const Text(
          'Create an account',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
