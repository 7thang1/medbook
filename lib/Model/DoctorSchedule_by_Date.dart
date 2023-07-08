class DoctorScheduleByDate {
  final int doctorID;
  final String doctorFullname;
  final int doctorRoomID;
  final String roomName;

  DoctorScheduleByDate({
    required this.doctorID,
    required this.doctorFullname,
    required this.doctorRoomID,
    required this.roomName,
  });

  factory DoctorScheduleByDate.fromJson(Map<String, dynamic> json) {
    return DoctorScheduleByDate(
      doctorID: json['doctorID'],
      doctorFullname: json['doctorFullname'],
      doctorRoomID: json['doctorRoomID'],
      roomName: json['roomName'],
    );
  }
}
