class Doctor {
  final int doctorID;
  final String doctorFullname;
  final String doctorGender;
  final int specialtyID;
  final String specialtyName;
  final String workDay;
  final String specialtyPrice;
  final String roomName;
  final int roomID;

  Doctor({
    required this.doctorID,
    required this.doctorFullname,
    required this.doctorGender,
    required this.specialtyID,
    required this.specialtyName,
    required this.workDay,
    required this.specialtyPrice,
    required this.roomName,
    required this.roomID,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      doctorID: json['doctorID'],
      doctorFullname: json['doctorFullname'],
      doctorGender: json['doctorGender'],
      specialtyID: json['specialtyID'],
      specialtyName: json['specialtyName'],
      workDay: json['workDay'],
      specialtyPrice: json['specialtyPrice'],
      roomName: json['roomName'],
      roomID: json['roomID'],
    );
  }
}
