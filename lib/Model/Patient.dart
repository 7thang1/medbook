class Patient {
  int? profileId;
  int? userId;
  String? fullName;
  String? dateOfBirth;
  String? gender;
  String? phoneNumber;
  String? address;
  String? occupation;
  String? ethnicity;

  Patient(
      {this.profileId,
      this.userId,
      this.fullName,
      this.dateOfBirth,
      this.gender,
      this.phoneNumber,
      this.address,
      this.occupation,
      this.ethnicity});

  Patient.fromJson(Map<String, dynamic> json) {
    profileId = json['profile_id'];
    userId = json['user_id'];
    fullName = json['full_name'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    occupation = json['occupation'];
    ethnicity = json['ethnicity'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['profile_id'] = this.profileId;
  //   data['user_id'] = this.userId;
  //   data['full_name'] = this.fullName;
  //   data['date_of_birth'] = this.dateOfBirth;
  //   data['gender'] = this.gender;
  //   data['phone_number'] = this.phoneNumber;
  //   data['address'] = this.address;
  //   data['occupation'] = this.occupation;
  //   data['ethnicity'] = this.ethnicity;
  //   return data;
  // }
}
