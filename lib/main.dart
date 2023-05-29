// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, must_be_immutable

import 'dart:js';

import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:medbook/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showpass = false;
  TextEditingController usercontroller = new TextEditingController();
  TextEditingController passcontroller = new TextEditingController();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            constraints: BoxConstraints.expand(),
            color: Color(0xFF121a25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Image.asset(
                    'assets/LOG2-removebg.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 40),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Text(
                    "Sign in your account",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF525761),
                        fontSize: 25),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    controller: usercontroller,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon:
                          Image.asset('assets/mail-icon.png', scale: 20),
                      fillColor: Color(0xFF202c3c),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF202c3c)),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      TextField(
                        controller: passcontroller,
                        obscureText: !showpass,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Image.asset('assets/password-icon.png',
                              scale: 20),
                          fillColor: Color(0xFF202c3c),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF202c3c)),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: onToggleShowPass,
                            child: showpass
                                ? Image.asset('assets/show.png', scale: 20)
                                : Image.asset('assets/hide.png', scale: 20),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0f7986),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onPressed: onSignInPressed,
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: TextButton(
                      onPressed: onForgotPasswordPressed,
                      child: Text(
                        'Forgot your password?',
                        style:
                            TextStyle(color: Color(0xFFb9bbbf), fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: Text(
                        'Or Continue With',
                        style:
                            TextStyle(color: Color(0xFF525761), fontSize: 20),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GoogleAuthButton(
                        onPressed: onGooglePressed,
                        text: 'Google',
                        themeMode: ThemeMode.dark,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FacebookAuthButton(
                        onPressed: onFacebookPressed,
                        text: 'Facebook',
                        themeMode: ThemeMode.dark,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Color(0xFF525761), fontSize: 20),
                    ),
                    TextButton(
                        onPressed: onSignUpPressed,
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ))
                  ],
                )
              ],
            ),
          )),
    );
  }

  void onToggleShowPass() {
    setState(() {
      showpass = !showpass;
    });
  }

  void onSignInPressed() {}
  void onForgotPasswordPressed() {}
  void onGooglePressed() {}
  void onFacebookPressed() {}
  void onSignUpPressed() {
    Navigator.push(
      context as BuildContext,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
  }
}
