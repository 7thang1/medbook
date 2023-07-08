import 'package:flutter/material.dart';
import 'package:medbook/Model/DoctorSchedule_by_Date.dart';
import 'package:medbook/Service/DoctorServices.dart';
import 'package:medbook/Model/DoctorSchedule.dart';

class ScheduleList extends StatefulWidget {
  final int doctorSpecialtyID;
  final int doctorScheduleDateID;
  const ScheduleList(
      {required this.doctorSpecialtyID, required this.doctorScheduleDateID})
      : super();
  @override
  _ScheduleListState createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  List<DoctorScheduleByDate> scheduleList = [];
  int selectedIndex = -1;
  List<DT> workingDates = [];
  int? doctorID;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final ScheduleList = await DoctorServices().getDoctorScheduleByDate(
        widget.doctorSpecialtyID, widget.doctorScheduleDateID);
    setState(() {
      scheduleList = ScheduleList;
    });
  }

  bool showWorkingHours = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vui lòng chọn phòng và giờ khám'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: scheduleList.length,
        itemBuilder: (BuildContext context, int index) {
          final doctorSchedule = scheduleList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showWorkingHours = !showWorkingHours;
                  doctorID = doctorSchedule.doctorID;
                  selectedIndex = index;
                  fetchSchedule(doctorID!, widget.doctorSpecialtyID,
                      widget.doctorScheduleDateID);
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/doctor.png',
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 10),
                              Text(
                                doctorSchedule.doctorFullname,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/location.png',
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 10),
                              Text(
                                doctorSchedule.roomName,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (showWorkingHours && selectedIndex == index)
                    SizedBox(
                        height:
                            10), // Add spacing between the container and WorkingHours
                  if (showWorkingHours && selectedIndex == index)
                    _buildWorkingHours(workingDates),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWorkingHours(List<DT> workingDates) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          (workingDates.length / 3).ceil(),
          (index) {
            final start = index * 3;
            final end = (index * 3) + 3 < workingDates.length
                ? (index * 3) + 3
                : workingDates.length;
            final hours = workingDates.sublist(start, end);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: hours.map((hour) => _buildWorkingHour(hour)).toList(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWorkingHour(DT hour) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          _selectWorkingHour(
              doctorID!, hour.roomID!, hour.timeslotID!, hour.timeslotName!);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Text(
            hour.timeslotName!, // Replace this with the appropriate property from your 'DT' model
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  void fetchSchedule(
      int doctorID, int specialtyID, int doctorScheduleDate) async {
    try {
      List<DT> data = await DoctorServices()
          .fetchDoctorSchedule(doctorID, specialtyID, doctorScheduleDate);
      setState(() {
        workingDates = data;
      });
    } catch (e) {
      // Xử lý lỗi tại đây
      print('Error: $e');
    }
  }

  void _selectWorkingHour(
      int doctorID, int roomID, int timeslotID, String timeslotName) {
    Map<String, dynamic> selectedTime = {
      'doctorID': doctorID,
      'roomID': roomID,
      'timeslotID': timeslotID,
      'timeslotName': timeslotName,
    };
    Navigator.pop(context, selectedTime);
  }
}
