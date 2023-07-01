import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:medbook/Screens/List/ethnicity.dart';
import 'package:medbook/Screens/List/job.dart';
import 'package:medbook/Screens/patientlist.dart';
import 'package:medbook/Service/UserManager.dart';
import 'package:medbook/Service/UserServices.dart';

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
  String? selectedJob;
  String? selectedEthnicity;
  APIService apiService = APIService();
  final userFullName = TextEditingController();
  final userPhone = TextEditingController();
  final userAddress = TextEditingController();

  final List<String> gender = ['Male', 'Female', 'Other'];

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // TextField - Họ và tên
                TextField(
                  controller: userFullName,
                  decoration: InputDecoration(
                    labelText: 'Họ và tên (*)',
                  ),
                ),
                const SizedBox(height: 16.0),
                // Row - Ngày sinh
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Ngày sinh:'),
                    const SizedBox(width: 8.0),
                    // DropdownButton - Ngày
                    DropdownButton<String>(
                      value: selectedDay,
                      hint: Text('Ngày'),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDay = newValue;
                          updateSelectedDate();
                        });
                      },
                      items: days.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(width: 20.0),
                    // DropdownButton - Tháng
                    DropdownButton<String>(
                      value: selectedMonth,
                      hint: Text('Tháng'),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedMonth = newValue;
                          updateSelectedDate();
                        });
                      },
                      items:
                          months.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(width: 20.0),
                    // DropdownButton - Năm
                    DropdownButton<String>(
                      value: selectedYear,
                      hint: Text('Năm'),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedYear = newValue;
                          updateSelectedDate();
                        });
                      },
                      items:
                          years.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                // DropdownButtonFormField - Giới tính
                Container(
                  height: 80.0,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Giới tính',
                    ),
                    value: selectedGender,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue;
                      });
                    },
                    items: gender.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10.0),
                // DropdownButtonFormField - Nghề nghiệp
                Container(
                  height: 80.0,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Nghề nghiệp',
                    ),
                    isExpanded: true,
                    value: selectedJob,
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
                const SizedBox(height: 10.0),
                // DropdownButtonFormField - Dân tộc
                Container(
                  height: 80.0,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Dân tộc',
                    ),
                    isExpanded: true,
                    value: selectedEthnicity,
                    onChanged: (String? newValue) {
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
                // TextField - Số điện thoại
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: userPhone,
                  decoration: InputDecoration(
                    labelText: 'Số điện thoại (*)',
                  ),
                ),
                // TextField - Địa chỉ
                TextField(
                  controller: userAddress,
                  decoration: InputDecoration(
                    labelText: 'Địa chỉ (*)',
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: onCreateInfoPressed,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      "TẠO HỒ SƠ",
                      style: TextStyle(fontSize: 15.0),
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
    if (userFullName.text.isEmpty ||
        selectedDob == null ||
        selectedGender == null ||
        userPhone.text.isEmpty ||
        userAddress.text.isEmpty ||
        selectedJob == null ||
        selectedEthnicity == null) {
      showSnackbar('Vui lòng điền đầy đủ thông tin.', false);
      return;
    }
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
