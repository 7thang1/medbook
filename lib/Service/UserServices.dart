import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medbook/Model/User.dart';

class UserServices {
  static const String baseUrl = 'http://20.24.151.181:8080/api';

  Future<Map<String, dynamic>> createPatient(
      int user_id,
      String patient_name,
      String patient_dob,
      String patient_gender,
      String patient_phone_number,
      String patient_address,
      String patient_occupation,
      String patient_ethnicity) async {
    final url = '$baseUrl/patient/register';
    final body = jsonEncode({
      'user_id': user_id,
      'patient_name': patient_name,
      'patient_dob': patient_dob,
      'patient_gender': patient_gender,
      'patient_phone_number': patient_phone_number,
      'patient_address': patient_address,
      'patient_occupation': patient_occupation,
      'patient_ethnicity': patient_ethnicity,
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
            'message': 'Tạo hồ sơ thành công',
          };
        } else {
          // Login failed
          return {
            'success': false,
            'message': 'Tạo hồ sơ thất bại',
          };
        }
      } else {
        // Handle non-200 status code
        return {
          'success': false,
          'message': 'Đã xảy ra lỗi 1',
        };
      }
    } catch (e) {
      // Handle network or server errors
      return {
        'success': false,
        'message': 'Đã xảy ra lỗi ',
      };
    }
  }

  Future<List<User>> getUserByUsername(String user_name) async {
    final response = await http.get(Uri.parse(
        'http://20.24.151.181:8080/api/user/get/username/$user_name'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final Userinfo = data['DT'] as List<dynamic>;
      return Userinfo.map((item) => User.fromJson(item)).toList();
    } else {
      throw Exception('Không thể tải thông tin');
    }
  }

  Future<void> resetPassword(int userId, String newPassword) async {
    final apiUrl = 'http://20.24.151.181:8080/api/user/resetpassword';

    final requestBody = {
      'user_id': userId,
      'reset_password': newPassword,
    };

    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print('Đặt lại mật khẩu thành công');
    } else {
      print('Reset password failed: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> updateUserInfo(
      int userId, String userName, String userPhone, String userMail) async {
    final apiUrl = 'http://20.24.151.181:8080/api/user/updateuserinfor';

    final requestBody = {
      'user_id': userId,
      'user_name': userName,
      'user_phone': userPhone,
      'user_mail': userMail,
    };

    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print('Cập nhật thông tin thành công');
    } else {
      print('Reset password failed: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }
}
