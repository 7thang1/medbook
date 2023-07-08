// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:medbook/Model/User.dart';
import 'package:medbook/Screens/login.dart';
import 'package:medbook/Service/UserServices.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  List<User> user = [];
  bool _showPass = true;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _newpasswordController = TextEditingController();
  TextEditingController _renewpasswordController = TextEditingController();
  GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      new GlobalKey<ScaffoldMessengerState>();

  void showSnackbar(String message, bool isSuccess) {
    Color snackbarColor = isSuccess ? Colors.green : Colors.red;
    Image snackbarImage = isSuccess
        ? Image.asset('assets/checking.png', width: 20, height: 20)
        : Image.asset('assets/error.png', width: 20, height: 20);
    final snackBar = SnackBar(
      backgroundColor: snackbarColor,
      duration: Duration(milliseconds: 1200),
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          snackbarImage,
          SizedBox(width: 8),
          Text(message),
        ],
      ),
    );

    _scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: ScaffoldMessenger(
        key: _scaffoldMessengerKey,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Text(
                      "QUÊN MẬT KHẨU",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: _usernameController,
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
                            borderSide:
                                BorderSide(color: Color(0xffCED0D2), width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10),
                  //   child: Stack(
                  //     alignment: AlignmentDirectional.centerEnd,
                  //     children: <Widget>[
                  //       TextField(
                  //         obscureText: _showPass,
                  //         style: TextStyle(fontSize: 18, color: Colors.black),
                  //         decoration: InputDecoration(
                  //           labelText: "MẬT KHẨU CŨ",
                  //           labelStyle: TextStyle(
                  //               color: Colors.blueAccent,
                  //               fontSize: 15,
                  //               fontWeight: FontWeight.bold),
                  //           prefix: Padding(
                  //             padding: const EdgeInsets.only(right: 5),
                  //             child: Container(
                  //               margin: EdgeInsets.only(right: 10, left: 5),
                  //               width: 25,
                  //               height: 25,
                  //               child: Image.asset("assets/password.png"),
                  //             ),
                  //           ),
                  //           border: OutlineInputBorder(
                  //               borderSide: BorderSide(
                  //                   color: Color(0xffCED0D2), width: 1),
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(10))),
                  //         ),
                  //       ),
                  //       GestureDetector(
                  //         onTap: onShowPassPressed,
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(right: 10),
                  //           child: Image.asset(
                  //             _showPass
                  //                 ? "assets/showpass.png"
                  //                 : "assets/hidepass.png",
                  //             width: 25,
                  //             height: 25,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        TextField(
                          controller: _newpasswordController,
                          obscureText: _showPass,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "MẬT KHẨU MỚI",
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
                          controller: _renewpasswordController,
                          obscureText: _showPass,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "NHẬP LẠI MẬT KHẨU MỚI",
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
                        onPressed: onForgetPasswordPressed,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text(
                          "ĐẶT LẠI MẬT KHẨU",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onShowPassPressed() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  void onForgetPasswordPressed() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_usernameController.text.isEmpty) {
      showSnackbar("Vui lòng nhập tài khoản", false);
    } else if (_newpasswordController.text.isEmpty ||
        _renewpasswordController.text.isEmpty) {
      showSnackbar("Vui lòng nhập mật khẩu", false);
    } else {
      if (_newpasswordController.text != _renewpasswordController.text) {
        showSnackbar("Mật khẩu không trùng khớp", false);
      } else {
        final userList =
            await UserServices().getUserByUsername(_usernameController.text);
        if (userList.isNotEmpty) {
          final userId = userList.first.user_id;
          final newPassword = _newpasswordController.text;
          await UserServices().resetPassword(userId, newPassword);
          showSnackbar("Đặt lại mật khẩu thành công", true);
          Timer(Duration(milliseconds: 1500), () {
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
                  return Login();
                },
              ),
            );
          });
        } else {
          showSnackbar("Người dùng không tồn tại", false);
        }
      }
    }
  }

  void onBackPressed() {}
}
