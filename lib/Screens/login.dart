// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_new, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medbook/Screens/home.dart';
import 'register.dart';
import 'resetpassword.dart';
import 'package:animations/animations.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _showPass = true;
  TextEditingController userName = new TextEditingController();
  TextEditingController userPassword = new TextEditingController();
  var _userError = "Tài khoản không hợp lệ";
  var _passError = "Mật khẩu không hợp lệ";
  var _userInvalid = false;
  var _passInvalid = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: MaterialApp(
          home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            constraints: BoxConstraints.expand(),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: double.infinity,
                      height: 100,
                      padding: EdgeInsets.only(
                        left: 5,
                      ),
                      margin: EdgeInsets.only(top: 50),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child:
                          Image.asset('assets/LOG7.png', fit: BoxFit.contain)),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Chào mừng",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 50,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "Đăng nhập vào tài khoản của bạn ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff6c7178),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextField(
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      controller: userName,
                      decoration: InputDecoration(
                        errorText: _userInvalid ? _userError : null,
                        labelText: "TÀI KHOẢN",
                        labelStyle: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        prefix: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(
                              margin: EdgeInsets.only(right: 10, left: 5),
                              width: 25,
                              height: 25,
                              child: Image.asset("assets/user.png")),
                        ),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffCED0D2), width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        TextField(
                          controller: userPassword,
                          obscureText: _showPass,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                            errorText: _passInvalid ? _passError : null,
                            labelText: "MẬT KHẨU",
                            labelStyle: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            prefix: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Container(
                                margin: EdgeInsets.only(right: 10, left: 5),
                                width: 25,
                                height: 25,
                                child: Image.asset("assets/password.png"),
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                        GestureDetector(
                          onTap: onShowPassPressed,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Image.asset(
                              _showPass
                                  ? "assets/showpass.png"
                                  : "assets/hidepass.png",
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: onSignInPressed,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text(
                          "ĐĂNG NHẬP",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 130,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: onSignUpPressed,
                          child: Text(
                            "ĐĂNG KÝ MỚI",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        GestureDetector(
                          onTap: onForgotPasswordPressed,
                          child: Text(
                            "Quên mật khẩu",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      )),
    );
  }

  void onSignInPressed() {
    setState(() {
      if (userName.text.length < 6 ||
          userName.text.length > 20 ||
          userName.text.contains(" ")) {
        _userInvalid = true;
      } else {
        _userInvalid = false;
      }
      if (userPassword.text.length < 6 || userPassword.text.length > 20) {
        _passInvalid = true;
      } else {
        _passInvalid = false;
      }
      if (!_userInvalid && !_passInvalid) {
        Navigator.pop(context);
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.scaled,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return Home();
            },
          ),
        );
      }
    });
  }

  void onForgotPasswordPressed() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.scaled,
            child: child,
          );
        },
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return ResetPassword();
        },
      ),
    );
  }

  void onSignUpPressed() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.scaled,
            child: child,
          );
        },
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Register();
        },
      ),
    );
  }

  void onShowPassPressed() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Bạn có muốn thoát ứng dụng?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Không'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Có'),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }
}
