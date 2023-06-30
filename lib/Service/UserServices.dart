import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medbook/Service/UserManager.dart';

class APIService {
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

  Future<Map<String, dynamic>> getListPatient(String user_id) async {
    final url = '$baseUrl/patient/get/list/1';

    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final errorCode = responseData['EC'];

        if (errorCode == 1) {
          // Lấy danh sách bệnh nhân thành công
          final List<dynamic> patientList = responseData['data'];

          return {
            'success': true,
            'message': 'Lấy danh sách bệnh nhân thành công',
            'patientList': patientList,
          };
        } else {
          // Lấy danh sách bệnh nhân thất bại
          return {
            'success': false,
            'message': 'Lấy danh sách bệnh nhân thất bại',
          };
        }
      } else {
        // Xử lý mã trạng thái không phải 200
        return {
          'success': false,
          'message': 'Đã xảy ra lỗi 1',
        };
      }
    } catch (e) {
      // Xử lý lỗi mạng hoặc lỗi server
      return {
        'success': false,
        'message': 'Đã xảy ra lỗi 2',
      };
    }
  }
}
