import 'package:flutter/material.dart';
import 'package:medbook/Model/DoctorSchedule.dart' as DoctorSchedule;
import 'package:medbook/Model/DoctorWorkingDates.dart' as DoctorWorkingDates;
import 'package:medbook/Model/Patient.dart';
import 'package:medbook/Screens/doctorlist.dart';
import 'package:medbook/Model/Doctor.dart';
import 'package:medbook/Screens/medicalexamination.dart';
import 'package:medbook/Screens/patientinfo.dart';
import 'package:medbook/Service/DoctorServices.dart';
import 'package:medbook/Service/TicketServices.dart';

class BookingByDoctor extends StatefulWidget {
  final Patient patient;
  const BookingByDoctor({required this.patient});

  @override
  _BookingByDoctorState createState() => _BookingByDoctorState();
}

class _BookingByDoctorState extends State<BookingByDoctor> {
  Doctor? selectedDoctor;
  String? selectedDate;
  String? selectedTime;
  Doctor? selectedSpecialty;
  DoctorServices doctorServices = DoctorServices();
  List<DoctorWorkingDates.DT> workingDates = [];
  List<DoctorSchedule.DT> doctorSchedule = [];
  int? ScheduleID;
  String? SelectedTime;
  int? TimeID;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldMessengerKey,
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
                          'assets/doctor.png',
                          width: 24,
                          height: 24,
                          color: Colors.blueAccent.shade200,
                        ),
                        InkWell(
                          onTap: () {
                            _navigateToDoctorList(context);
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedDoctor != null
                                      ? selectedDoctor!.doctorFullname
                                      : 'Chọn bác sĩ...',
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
                        Image.asset('assets/stethoscope.png',
                            width: 24,
                            height: 24,
                            color: Colors.blueAccent.shade200),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: Text(
                            selectedDoctor != null
                                ? '${selectedDoctor!.specialtyName}'
                                : '',
                            style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: Colors.blueAccent.shade200),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/calendar.png',
                            width: 24,
                            height: 24,
                            color: Colors.blueAccent.shade200),
                        if (workingDates.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: workingDates.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                childAspectRatio: 2,
                              ),
                              itemBuilder: (context, index) {
                                final dt = workingDates[index];
                                final day = dt.dateValue?.substring(8, 10);
                                final month = dt.dateValue?.substring(5, 7);
                                final year = dt.dateValue?.substring(0, 4);
                                final formattedDate = '$day/$month/$year';

                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedDate = dt.dateValue;
                                      fetchDoctorSchedule(
                                          selectedDoctor!.doctorID,
                                          selectedDoctor!.specialtyID,
                                          dt.dateId!);
                                      ScheduleID = dt.dateId;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedDate == dt.dateValue
                                          ? Colors.blue.withOpacity(0.3)
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        formattedDate,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: selectedDate == dt.dateValue
                                              ? Colors.blue
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/clock.png',
                              width: 24,
                              height: 24,
                              color: Colors.blueAccent.shade200),
                          if (doctorSchedule.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 200,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: doctorSchedule.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 3.5,
                                  ),
                                  itemBuilder: (context, index) {
                                    final data = doctorSchedule[index];
                                    final isAvailable =
                                        data.slotStatus == 'Available';

                                    return InkWell(
                                      onTap: () {
                                        if (isAvailable) {
                                          setState(() {
                                            selectedTime = data.timeslotName!;
                                            ScheduleID = data.dateID;
                                            TimeID = data.timeslotID;
                                          });
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              selectedTime == data.timeslotName
                                                  ? Colors.blue.withOpacity(0.3)
                                                  : Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            data.timeslotName!,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: selectedDate ==
                                                      data.timeslotName
                                                  ? Colors.blue
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                        foregroundDecoration: !isAvailable
                                            ? BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              )
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                        ]),
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
    );
  }

  void _navigateToDoctorList(BuildContext context) async {
    final selectedDoctor = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DoctorList()),
    );
    if (selectedDoctor != null) {
      setState(() {
        this.selectedDoctor = selectedDoctor;
        fetchWorkingDate(selectedDoctor.doctorID, selectedDoctor.specialtyID);
      });
    }
  }

  void fetchWorkingDate(int doctorID, int specialtyID) async {
    try {
      List<DoctorWorkingDates.DT> data =
          await doctorServices.fetchWorkingDate(doctorID, specialtyID);

      setState(() {
        workingDates = data;
      });
    } catch (e) {
      // Xử lý lỗi tại đây
      print('Error: $e');
    }
  }

  void fetchDoctorSchedule(
      int doctorID, int specailtyID, int doctorScheduleDate) async {
    try {
      List<DoctorSchedule.DT> schedule = await doctorServices
          .fetchDoctorSchedule(doctorID, specailtyID, doctorScheduleDate);
      setState(() {
        doctorSchedule = schedule;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> onBookingPressed() async {
    if (selectedDoctor == null) {
      showSnackbar('Vui lòng chọn bác sĩ', false);
      return;
    } else if (selectedDate == null) {
      showSnackbar('Vui lòng chọn ngày khám', false);
    } else if (selectedTime == null) {
      showSnackbar('Vui lòng chọn giờ khám', false);
    } else {
      final result = await ticketServices.createTicket(
        widget.patient.profileId!,
        selectedDoctor!.doctorID,
        selectedDoctor!.specialtyID,
        selectedDoctor!.roomID,
        ScheduleID!,
        TimeID!,
      );
      if (!result.isEmpty) {
        showSnackbar('Đặt lịch thành công', true);
        Navigator.of(context).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MedicalRecord()));
      } else {
        showSnackbar(result['message'], false);
      }
    }
  }
}
