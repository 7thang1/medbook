class UserManager {
  static final UserManager _instance = UserManager._internal();
  factory UserManager() => _instance;

  int? userId;

  UserManager._internal();
}
