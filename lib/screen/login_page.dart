import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../provider/auth_provider.dart';

enum Status {
  login,
  signUp,
}

Status type = Status.login;

class LoginPage extends StatefulWidget {
  static const routename = '/LoginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();

  bool _isLoading = false;
  bool _isLoading2 = false;
  void loading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void loading2() {
    setState(() {
      _isLoading2 = !_isLoading2;
    });
  }

  void _switchType() {
    if (type == Status.signUp) {
      setState(() {
        type = Status.login;
      });
    } else {
      setState(() {
        type = Status.signUp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, _) {
            final _auth = ref.watch(authenticationProvider);

            Future<void> _onPressedFunction() async {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              if (type == Status.login) {
                loading();
                await _auth
                    .signInWithEmailAndPassword(_email.text, _password.text, context)
                    .whenComplete(
                      () => _auth.authStateChange.listen(
                        (event) async {
                          if (event == null) {
                            loading();
                            return;
                          }
                        },
                      ),
                    );
              } else {
                loading();
                await _auth
                    .signUpWithEmailAndPassword(
                      email: _email.text,
                      password: _password.text,
                      context: context,
                      name: _name.text,
                    )
                    .whenComplete(
                      () => _auth.authStateChange.listen(
                        (event) async {
                          if (event == null) {
                            loading();
                            return;
                          }
                        },
                      ),
                    );
              }
            }

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(
                      40.0,
                      40.0,
                      40.0,
                      0.0,
                    ),
                    child: Center(
                      child: FlutterLogo(size: 70),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      margin: const EdgeInsets.only(top: 48),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (type == Status.signUp)
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextFormField(
                                controller: _name,
                                autocorrect: false,
                                enableSuggestions: true,
                                keyboardType: TextInputType.name,
                                onSaved: (value) {},
                                decoration: InputDecoration(
                                  hintText: 'Your name',
                                  hintStyle: const TextStyle(color: Colors.black54),
                                  icon: Icon(
                                    Icons.account_circle,
                                    color: Colors.blue.shade700,
                                    size: 24,
                                  ),
                                  alignLabelWithHint: true,
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Name not given';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 24,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextFormField(
                              controller: _email,
                              autocorrect: true,
                              enableSuggestions: true,
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (value) {},
                              decoration: InputDecoration(
                                hintText: 'Email address',
                                hintStyle: const TextStyle(color: Colors.black54),
                                icon: Icon(Icons.email_outlined,
                                    color: Colors.blue.shade700, size: 24),
                                alignLabelWithHint: true,
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'Invalid email!';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: TextFormField(
                              controller: _password,
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 6) {
                                  return 'Password is too short!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: const TextStyle(color: Colors.black54),
                                icon: Icon(
                                  CupertinoIcons.lock_circle,
                                  color: Colors.blue.shade700,
                                  size: 24,
                                ),
                                alignLabelWithHint: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          if (type == Status.signUp)
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 600),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 8,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Confirm password',
                                  hintStyle: const TextStyle(color: Colors.black54),
                                  icon: Icon(
                                    CupertinoIcons.lock_circle,
                                    color: Colors.blue.shade700,
                                    size: 24,
                                  ),
                                  alignLabelWithHint: true,
                                  border: InputBorder.none,
                                ),
                                validator: type == Status.signUp
                                    ? (value) {
                                        if (value != _password.text) {
                                          return 'Passwords do not match!';
                                        }
                                        return null;
                                      }
                                    : null,
                              ),
                            ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 32.0),
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            width: double.infinity,
                            child: _isLoading
                                ? const Center(child: CircularProgressIndicator())
                                : MaterialButton(
                                    onPressed: _onPressedFunction,
                                    child: Text(
                                      type == Status.login ? 'Log in' : 'Sign up',
                                      style: const TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    textColor: Colors.blue.shade700,
                                    textTheme: ButtonTextTheme.primary,
                                    minWidth: 100,
                                    padding: const EdgeInsets.all(18),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      side: BorderSide(color: Colors.blue.shade700),
                                    ),
                                  ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: RichText(
                              text: TextSpan(
                                text: type == Status.login
                                    ? 'Don\'t have an account? '
                                    : 'Already have an account? ',
                                style: const TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: type == Status.login ? 'Sign up now' : 'Log in',
                                    style: TextStyle(color: Colors.blue.shade700),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        _switchType();
                                      },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
