// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:medbook/Screens/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _showPass = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Container(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            constraints: BoxConstraints.expand(),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                          width: double.infinity,
                          height: 100,
                          margin: EdgeInsets.only(top: 50),
                          padding: EdgeInsets.only(
                            left: 0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Image.asset('assets/LOG7.png',
                              fit: BoxFit.contain)),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "Đăng ký tài khoản",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff6c7178),
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextField(
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
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
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextField(
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "HỌ VÀ TÊN",
                            labelStyle: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),
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
                              obscureText: _showPass,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              decoration: InputDecoration(
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
                        padding: const EdgeInsets.only(top: 10),
                        child: Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: <Widget>[
                            TextField(
                              obscureText: _showPass,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              decoration: InputDecoration(
                                labelText: "NHẬP LẠI MẬT KHẨU",
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
                            onPressed: onSignUpPressed,
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Text(
                              "ĐĂNG KÝ",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  void onShowPassPressed() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  void onSignUpPressed() {
    Navigator.pop(
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
          return Login();
        },
      ),
    );
  }
}
