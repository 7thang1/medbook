import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medbook/Model/DoctorSchedule.dart' as DoctorSchedule;
import 'package:medbook/Model/DoctorSchedule_by_Date.dart';
import 'package:medbook/Model/DoctorWorkingDates.dart' as DoctorWorkingDates;
import 'package:medbook/Model/ListDate.dart';
import 'package:medbook/Model/Patient.dart';
import 'package:medbook/Model/Speciality.dart';
import 'package:medbook/Screens/medicalexamination.dart';
import 'package:medbook/Screens/patientinfo.dart';
import 'package:medbook/Screens/speciality_list.dart';
import 'package:medbook/Service/DoctorServices.dart';
import 'package:medbook/Service/TicketServices.dart';
import 'package:medbook/doctor_schedule_by_date_list.dart';

class BookingByDates extends StatefulWidget {
  final Patient patient;
  const BookingByDates({required this.patient});

  @override
  _BookingByDatesState createState() => _BookingByDatesState();
}

class _BookingByDatesState extends State<BookingByDates> {
  @override
  initState() {
    super.initState();
    getDateList();
  }

  String? roomName;
  String? DateSelected;
  int? doctorID;
  int? roomID;
  int? timeslotID;
  String? timeslotName;
  List<DateTime> availableDates = [];
  List<DoctorScheduleByDate> doctorScheduleByDateList = [];
  int? selectedDateId;
  List<ListDate> dateList = [];
  Speciality? selectedSpecialty;
  ListDate? selectedDate;
  DoctorServices doctorServices = DoctorServices();
  List<DoctorWorkingDates.DT> workingDates = [];
  List<DoctorSchedule.DT> doctorSchedule = [];
  DoctorSchedule.DT? selectedTime;
  TicketServices ticketServices = TicketServices();
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

  Future<void> getDateList() async {
    try {
      List<ListDate> dates = await DoctorServices().getDateList();
      setState(() {
        dateList = dates;
        availableDates =
            dateList.map((date) => DateTime.parse(date.date_value)).toList();
      });
    } catch (e) {
      print('Đã xảy ra lỗi: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          title: Text('Đặt lịch khám'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 710,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 5)),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PatientInfo(patient: widget.patient),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/userfilled.png',
                              width: 24,
                              height: 24,
                              color: Colors.blueAccent.shade400,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                widget.patient.fullName!,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.blueAccent.shade400,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                alignment: AlignmentDirectional.centerEnd,
                                child: Icon(Icons.arrow_forward,
                                    color: Colors.blueAccent)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/calendar.png',
                            width: 24,
                            height: 24,
                            color: Colors.blueAccent.shade200,
                          ),
                          InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateSelected ?? 'Chọn ngày khám...',
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.5,
                                      color: Colors.blueAccent.shade200,
                                    ),
                                  ),
                                  Container(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Icon(Icons.arrow_forward),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset('assets/stethoscope.png',
                              width: 24,
                              height: 24,
                              color: Colors.blueAccent.shade200),
                          InkWell(
                            onTap: () {
                              _navigateToSpecialityList(context);
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedSpecialty != null
                                        ? selectedSpecialty!.name
                                        : 'Chọn chuyên khoa',
                                    style: TextStyle(
                                        fontSize: 16,
                                        height: 1.5,
                                        color: Colors.blueAccent.shade200),
                                  ),
                                  Container(
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: Icon(Icons.arrow_forward)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset('assets/clock.png',
                              width: 24,
                              height: 24,
                              color: Colors.blueAccent.shade200),
                          InkWell(
                            onTap: () {
                              _navigateToScheduleList(context);
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedTime != null
                                        ? timeslotName!
                                        : 'Chọn phòng khám và giờ khám',
                                    style: TextStyle(
                                        fontSize: 16,
                                        height: 1.5,
                                        color: Colors.blueAccent.shade200),
                                  ),
                                  Container(
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: Icon(Icons.arrow_forward)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Container(
                        alignment: AlignmentDirectional.bottomCenter,
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => onBookingPressed(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            child: Text(
                              'Đặt lịch khám',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
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
      ),
    );
  }

  void _navigateToSpecialityList(BuildContext context) async {
    final selectedSpecialty = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SpecialityList()),
    );
    if (selectedSpecialty != null) {
      setState(() {
        this.selectedSpecialty = selectedSpecialty;
      });
    }
  }

  void _navigateToScheduleList(BuildContext context) async {
    final selectedTime = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ScheduleList(
                doctorSpecialtyID: selectedSpecialty!.specialty_id,
                doctorScheduleDateID: selectedDateId!,
              )),
    );
    if (selectedTime != null) {
      setState(() {
        doctorID = selectedTime['doctorID'];
        roomID = selectedTime['roomID'];
        timeslotID = selectedTime['timeslotID'];
        timeslotName = selectedTime['timeslotName'];
        this.selectedTime = DoctorSchedule.DT(
          doctorID: selectedTime['doctorID'],
          roomID: selectedTime['roomID'],
          timeslotID: selectedTime['timeslotID'],
          timeslotName: selectedTime['timeslotName'],
        );
      });
    }
  }

  Future<void> onBookingPressed() async {
    if (selectedSpecialty == null) {
      showSnackbar('Vui lòng chọn chuyên khoa', false);
      return;
    } else if (DateSelected == null) {
      showSnackbar('Vui lòng chọn ngày khám', false);
      // } else {
      //   showSnackbar(
      //       widget.patient.profileId.toString() +
      //           '-' +
      //           doctorID.toString() +
      //           '-' +
      //           selectedSpecialty!.specialty_id.toString() +
      //           '-' +
      //           roomID.toString() +
      //           '-' +
      //           selectedDateId.toString() +
      //           '-' +
      //           timeslotID.toString(),
      //       true);
      // }
    } else {
      final result = await ticketServices.createTicket(
        widget.patient.profileId!,
        doctorID!,
        selectedSpecialty!.specialty_id,
        roomID!,
        selectedDateId!,
        timeslotID!,
      );
      if (!result.isEmpty) {
        showSnackbar('Đặt lịch thành công', true);
        Timer(Duration(milliseconds: 1500), () {
          Navigator.of(context).pop();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MedicalRecord()));
        });
      } else {
        showSnackbar(result['message'], false);
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    dateList = await DoctorServices().getDateList();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year, now.month, now.day),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      selectableDayPredicate: (DateTime date) {
        return availableDates.contains(date);
      },
    );

    if (picked != null) {
      setState(() {
        final DateFormat formatter = DateFormat('dd/MM/yyyy');
        final DateFormat formatter_2 = DateFormat('yyyy-MM-dd');
        String Date_for_check = formatter_2.format(picked);
        DateSelected = formatter.format(picked);
        selectedDateId = dateList
            .firstWhere((date) => date.date_value == Date_for_check)
            .date_id;
        this.dateList = dateList;
      });
    }
  }
}
