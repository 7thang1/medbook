class Ticket {
  String? eM;
  int? eC;
  List<DT>? dT;

  Ticket({this.eM, this.eC, this.dT});

  Ticket.fromJson(Map<String, dynamic> json) {
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
    patientName = json['patientName'];
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
    data['patientName'] = this.patientName;
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
