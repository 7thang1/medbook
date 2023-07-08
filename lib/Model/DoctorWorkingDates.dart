class DoctorWorkingDates {
  String? eM;
  int? eC;
  List<DT>? dT;

  DoctorWorkingDates({this.eM, this.eC, this.dT});

  DoctorWorkingDates.fromJson(Map<String, dynamic> json) {
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
  int? dateId;
  String? dateValue;

  DT({this.dateId, this.dateValue});

  DT.fromJson(Map<String, dynamic> json) {
    dateId = json['date_id'];
    dateValue = json['date_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date_id'] = this.dateId;
    data['date_value'] = this.dateValue;
    return data;
  }
}
