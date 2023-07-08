// ignore_for_file: unused_import, prefer_const_constructors

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:medbook/Screens/aboutus.dart';
import 'package:medbook/Screens/guide.dart';
import 'package:medbook/Screens/home.dart';
import 'package:medbook/Screens/login.dart';
import 'package:medbook/Screens/medicalexamination.dart';
import 'package:medbook/Screens/patientinfo.dart';
import 'package:medbook/Screens/patientlist.dart';
import 'package:medbook/Screens/register.dart';
import 'package:medbook/Screens/setting.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Nguyễn Văn A"),
            accountEmail: Text("example@gmail.com"),
            currentAccountPicture: GestureDetector(
              onTap: () => onUserInfoPressed(context),
              child: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    'assets/avatar.png',
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: SizedBox(
                width: 24, height: 24, child: Image.asset('assets/home.png')),
            title: Text("Trang chủ",
                style: TextStyle(fontSize: 13.5, color: Colors.black)),
            onTap: () => onHomePressed(context),
          ),
          ListTile(
            leading: SizedBox(
                width: 24,
                height: 24,
                child: Image.asset('assets/patientinformation.png')),
            title: Text("Hồ sơ bệnh nhân",
                style: TextStyle(fontSize: 13.5, color: Colors.black)),
            onTap: () => onPatientInformationPressed(context),
          ),
          ListTile(
            leading: SizedBox(
                width: 24,
                height: 24,
                child: Image.asset('assets/medicalexamination.png')),
            title: Text("Phiếu khám bệnh",
                style: TextStyle(fontSize: 13.5, color: Colors.black)),
            onTap: () => onMedicalExaminationPressed(context),
          ),
          ListTile(
            leading: SizedBox(
                width: 24, height: 24, child: Image.asset('assets/guide.png')),
            title: Text("Hướng dẫn",
                style: TextStyle(fontSize: 13.5, color: Colors.black)),
            onTap: () => onGuidePressed(context),
          ),
          ListTile(
            leading: SizedBox(
                width: 24,
                height: 24,
                child: Image.asset('assets/aboutus.png')),
            title: Text(
              "Giới thiệu",
              style: TextStyle(fontSize: 13.5, color: Colors.black),
            ),
            onTap: () => onAboutUsPressed(context),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          // ListTile(
          //     leading: SizedBox(
          //       width: 24,
          //       height: 24,
          //       child: Image.asset('assets/settings.png'),
          //     ),
          //     title: Text("Cài đặt",
          //         style: TextStyle(fontSize: 13.5, color: Colors.black)),
          //     onTap: () => onSettingPressed(context)),
          ListTile(
            leading: SizedBox(
              width: 24,
              height: 24,
              child: Image.asset('assets/logout.png'),
            ),
            title: Text("Đăng xuất",
                style: TextStyle(fontSize: 13.5, color: Colors.black)),
            onTap: () => onLogoutPressed(context),
          )
        ],
      ),
    );
  }

  void onPatientInformationPressed(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return ListInfo();
        },
      ),
    );
  }

  void onMedicalExaminationPressed(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return MedicalRecord();
        },
      ),
    );
  }

  void onHomePressed(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushReplacement(
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
          return Home();
        },
      ),
    );
  }

  void onLogoutPressed(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushReplacement(
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

  void onSettingPressed(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushReplacement(
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
          return Settings();
        },
      ),
    );
  }

  void onAboutUsPressed(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushReplacement(
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
          return AboutUs();
        },
      ),
    );
  }

  void onGuidePressed(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushReplacement(
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
          return Guide();
        },
      ),
    );
  }

  void onUserInfoPressed(BuildContext context) {}
}
