class TicketList {
  String? eM;
  int? eC;
  List<DT>? dT;

  TicketList({this.eM, this.eC, this.dT});

  TicketList.fromJson(Map<String, dynamic> json) {
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
  int? ticketID;
  int? patientProfileID;
  String? patientName;
  String? doctorName;
  String? specialtyName;
  String? roomName;
  String? placedDate;
  String? timeslot;

  String? ticketStatus;
  String? ticketPrice;

  DT(
      {this.ticketID,
      this.patientProfileID,
      this.patientName,
      this.doctorName,
      this.specialtyName,
      this.roomName,
      this.placedDate,
      this.timeslot,
      this.ticketStatus,
      this.ticketPrice});

  DT.fromJson(Map<String, dynamic> json) {
    ticketID = json['ticketID'];
    patientProfileID = json['patientProfileID'];
    patientName = json['patientFullname'];
    doctorName = json['doctorName'];
    specialtyName = json['specialtyName'];
    roomName = json['roomName'];
    placedDate = json['placedDate'];
    timeslot = json['timeslot'];
    ticketStatus = json['ticketStatus'];
    ticketPrice = json['ticketPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticketID'] = this.ticketID;
    data['patientProfileID'] = this.patientProfileID;
    data['patientFullname'] = this.patientName;
    data['doctorName'] = this.doctorName;
    data['specialtyName'] = this.specialtyName;
    data['roomName'] = this.roomName;
    data['placedDate'] = this.placedDate;
    data['timeslot'] = this.timeslot;
    data['ticketStatus'] = this.ticketStatus;
    data['ticketPrice'] = this.ticketPrice;
    return data;
  }
}
