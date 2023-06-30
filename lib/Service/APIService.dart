import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medbook/Service/UserManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  static const String baseUrl = 'http://20.24.151.181:8080/api';

  Future<Map<String, dynamic>> loginUser(
      String username, String password) async {
    final url = '$baseUrl/user/login';
    final body = jsonEncode({
      'userName': username,
      'userPassword': password,
    });
    final headers = {'Content-Type': 'application/json'};

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final errorCode = responseData['EC'];
        final data = responseData['DT'];
        final int userId = data['user_id'];
        UserManager().userId = userId;

        if (errorCode == 1) {
          return {
            'success': true,
            'message': 'Đăng nhập thành công',
            'user_id': data['user_id'],
            'user_name': data['user_name'],
            'userStatus': data['userStatus'],
            'password': data['password'],
          };
        } else {
          // Login failed
          return {
            'success': false,
            'message': 'Tên đăng nhập hoặc mật khẩu không chính xác',
          };
        }
      } else {
        // Handle non-200 status code
        return {
          'success': false,
          'message': 'Đã xảy ra lỗi',
        };
      }
    } catch (e) {
      // Handle network or server errors
      return {
        'success': false,
        'message': 'Đã xảy ra lỗi1',
      };
    }
  }

  Future<Map<String, dynamic>> registerUser(
      String username, String fullname, String password) async {
    final url = '$baseUrl/user/register';
    final body = jsonEncode({
      'user_name': username,
      'full_name': fullname,
      'user_password': password,
    });
    final headers = {'Content-Type': 'application/json'};

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final errorCode = responseData['EC'];

        if (errorCode == 1) {
          // Login success
          return {
            'success': true,
            'message': 'Đăng ký thành công',
          };
        } else {
          // Login failed
          return {
            'success': false,
            'message': 'Tên đăng nhập đã tồn tại',
          };
        }
      } else {
        // Handle non-200 status code
        return {
          'success': false,
          'message': 'Đã xảy ra lỗi',
        };
      }
    } catch (e) {
      // Handle network or server errors
      return {
        'success': false,
        'message': 'Đã xảy ra lỗi',
      };
    }
  }
}
