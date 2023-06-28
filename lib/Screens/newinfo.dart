import 'package:flutter/material.dart';
import 'package:medbook/Screens/List/ethnicity.dart';
import 'package:medbook/Screens/List/job.dart';
import 'List/countries.dart';
import 'List/province.dart';

class NewPatient extends StatefulWidget {
  const NewPatient({Key? key}) : super(key: key);

  @override
  _NewPatientState createState() => _NewPatientState();
}

class _NewPatientState extends State<NewPatient> {
  String? selectedDay;
  String? selectedMonth;
  String? selectedYear;
  String? selectedGender;
  String? selectedNationality;
  String? selectedJob;
  String? selectedEthnicity;
  String? selectedProvince;
  final List<String> gender = ['Nam', 'Nữ', 'Khác'];
  bool isEthnicityDisabled() {
    return selectedNationality != 'Vietnam' && selectedEthnicity == 'Khác';
  }

  final List<String> days =
      List.generate(31, (index) => (index + 1).toString());
  final List<String> months = [
    'Tháng 1',
    'Tháng 2',
    'Tháng 3',
    'Tháng 4',
    'Tháng 5',
    'Tháng 6',
    'Tháng 7',
    'Tháng 8',
    'Tháng 9',
    'Tháng 10',
    'Tháng 11',
    'Tháng 12',
  ];
  final List<String> years =
      List.generate(104, (index) => (1920 + index).toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo hồ sơ mới'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
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
                    items: gender.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'CMND/Passport',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedNationality,
                    hint: Text('Quốc tịch (*)'),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedNationality = newValue;
                        if (newValue == 'Vietnam') {
                          selectedEthnicity = Ethnicity.ethnicity[0];
                        } else {
                          selectedEthnicity = Ethnicity.ethnicity[62];
                        }
                      });
                    },
                    items: Countries.countries
                        .map<DropdownMenuItem<String>>((String value) {
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
                decoration: InputDecoration(
                  labelText: 'Số điện thoại (*)',
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
              TextField(
                decoration: InputDecoration(
                  labelText: 'Số điện thoại (*)',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedProvince,
                    hint: Text('Tỉnh thành'),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedProvince = newValue;
                      });
                    },
                    items: Province.province
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
    );
  }

  void onCreateInfoPressed() {}
}
