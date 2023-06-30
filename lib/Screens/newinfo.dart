import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medbook/Screens/List/ethnicity.dart';
import 'package:medbook/Screens/List/job.dart';
import 'package:medbook/Screens/patientlist.dart';
import 'package:medbook/Service/UserManager.dart';
import 'List/countries.dart';
import 'List/province.dart';
import 'package:medbook/Service/UserServices.dart';

import 'home.dart';

class NewPatient extends StatefulWidget {
  const NewPatient({Key? key}) : super(key: key);

  @override
  _NewPatientState createState() => _NewPatientState();
}

class _NewPatientState extends State<NewPatient> {
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

  String? selectedDob;
  String? selectedDay;
  String? selectedMonth;
  String? selectedYear;
  String? selectedGender;
  String? selectedNationality;
  String? selectedJob;
  String? selectedEthnicity;
  String? selectedProvince;
  APIService apiService = APIService();
  final userFullName = TextEditingController();
  final userPhone = TextEditingController();
  final userAddress = TextEditingController();

  final List<String> gender = ['Male', 'Female', 'Other'];
  bool isEthnicityDisabled() {
    return selectedNationality != 'Vietnam' && selectedEthnicity == 'Khác';
  }

  final List<String> days =
      List.generate(31, (index) => (index + 1).toString());
  final List<String> months = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  final List<String> years =
      List.generate(104, (index) => (1920 + index).toString());

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Tạo hồ sơ mới'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: userFullName,
                  decoration: InputDecoration(
                    labelText: 'Họ và tên (*)',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Ngày sinh:'),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: DropdownButton<String>(
                            value: selectedDay,
                            hint: Text('Ngày'),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedDay = newValue;
                                updateSelectedDate();
                              });
                            },
                            items: days
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(width: 20),
                        DropdownButton<String>(
                          value: selectedMonth,
                          hint: Text('Tháng'),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedMonth = newValue;
                              updateSelectedDate();
                            });
                          },
                          items: months
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: 20),
                        DropdownButton<String>(
                          value: selectedYear,
                          hint: Text('Năm'),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedYear = newValue;
                              updateSelectedDate();
                            });
                          },
                          items: years
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: DropdownButton<String>(
                      value: selectedGender,
                      isExpanded: true,
                      hint: Text('Giới tính'),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGender = newValue;
                        });
                      },
                      items:
                          gender.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedJob,
                      hint: Text('Nghề nghiệp'),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedJob = newValue;
                        });
                      },
                      items:
                          Job.job.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedEthnicity,
                      hint: Text('Dân tộc'),
                      onChanged: isEthnicityDisabled()
                          ? null
                          : (String? newValue) {
                              setState(() {
                                selectedEthnicity = newValue;
                              });
                            },
                      items: Ethnicity.ethnicity
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                TextField(
                  controller: userPhone,
                  decoration: InputDecoration(
                    labelText: 'Số điện thoại (*)',
                  ),
                ),
                TextField(
                  controller: userAddress,
                  decoration: InputDecoration(
                    labelText: 'Địa chỉ (*)',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: onCreateInfoPressed,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        "TẠO HỒ SƠ",
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
    );
  }

  Future<void> onCreateInfoPressed() async {
    final userDob = selectedDob.toString();
    final int? userID = UserManager().userId;
    var response = await apiService.createPatient(
        userID!,
        userFullName.text,
        userDob,
        selectedGender.toString(),
        userPhone.text,
        userAddress.text,
        selectedJob.toString(),
        selectedEthnicity.toString());
    if (response['success']) {
      bool state = true;
      showSnackbar(response['message'], state);
      Timer(Duration(milliseconds: 1500), () {
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
              return ListInfo();
            },
          ),
        );
      });
    } else {
      bool state = false;
      showSnackbar(response['message'], state);
    }
    ;
  }

  void updateSelectedDate() {
    if (selectedDay != null && selectedMonth != null && selectedYear != null) {
      selectedDob = '$selectedYear-$selectedMonth-$selectedDay';
    } else {
      selectedDob = null;
    }
  }
}
