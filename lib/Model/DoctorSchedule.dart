class DoctorSchedule {
  String? eM;
  int? eC;
  List<DT>? dT;

  DoctorSchedule({this.eM, this.eC, this.dT});

  DoctorSchedule.fromJson(Map<String, dynamic> json) {
    eM = json['EM'];
    eC = json['EC'];
    if (json['DT'] != null) {
      dT = <DT>[];
      json['DT'].forEach((v) {
        dT!.add(new DT.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EM'] = this.eM;
    data['EC'] = this.eC;
    if (this.dT != null) {
      data['DT'] = this.dT!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DT {
  int? doctorID;
  String? doctorName;
  int? roomID;
  String? roomName;
  int? dateID;
  String? date;
  int? timeslotID;
  String? timeslotName;
  String? slotStatus;

  DT(
      {this.doctorID,
      this.doctorName,
      this.roomID,
      this.roomName,
      this.dateID,
      this.date,
      this.timeslotID,
      this.timeslotName,
      this.slotStatus});

  DT.fromJson(Map<String, dynamic> json) {
    doctorID = json['doctorID'];
    doctorName = json['doctorName'];
    roomID = json['roomID'];
    roomName = json['roomName'];
    dateID = json['dateID'];
    date = json['date'];
    timeslotID = json['timeslotID'];
    timeslotName = json['timeslotName'];
    slotStatus = json['slotStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorID'] = this.doctorID;
    data['doctorName'] = this.doctorName;
    data['roomID'] = this.roomID;
    data['roomName'] = this.roomName;
    data['dateID'] = this.dateID;
    data['date'] = this.date;
    data['timeslotID'] = this.timeslotID;
    data['timeslotName'] = this.timeslotName;
    data['slotStatus'] = this.slotStatus;
    return data;
  }
}
