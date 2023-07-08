class User {
  final int user_id;
  final String user_name;
  final String full_name;
  final String phone_number;
  final String password;
  final String email;
  final int userStatus;
  final String join_date;

  User({
    required this.user_id,
    required this.user_name,
    required this.full_name,
    required this.phone_number,
    required this.password,
    required this.email,
    required this.userStatus,
    required this.join_date,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      user_id: json['user_id'],
      user_name: json['user_name'],
      full_name: json['full_name'],
      phone_number: json['phone_number'],
      password: json['password'],
      email: json['email'],
      userStatus: json['userStatus'],
      join_date: json['join_date'],
    );
  }
}
