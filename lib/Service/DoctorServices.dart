import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medbook/Model/Doctor.dart';
import 'package:medbook/Model/DoctorSchedule_by_Date.dart';
import 'package:medbook/Model/DoctorWorkingDates.dart' as DoctorWorkingDates;
import 'package:medbook/Model/DoctorSchedule.dart' as DoctorSchedule;
import 'package:medbook/Model/ListDate.dart';
import 'package:medbook/Model/Speciality.dart';

class DoctorServices {
  static const String baseUrl = 'http://20.24.151.181:8080/api';

  Future<List<Doctor>> getDoctorList(int startIndex, int pageSize) async {
    final response = await http.get(Uri.parse(
        'http://20.24.151.181:8080/api/doctor/get/listpagination?start_index=$startIndex&page_size=$pageSize'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final doctorList = data['DT'] as List<dynamic>;

      return doctorList.map((item) => Doctor.fromJson(item)).toList();
    } else {
      throw Exception('Không thể tải danh sách');
    }
  }

  Future<List<DoctorWorkingDates.DT>> fetchWorkingDate(
      int doctorID, int specialtyID) async {
    final String baseURL = 'http://20.24.151.181:8080/api';
    String url = '$baseURL/doctor/get/workingdates/$doctorID/$specialtyID';

    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        String responseBody = response.body;
        List<DoctorWorkingDates.DT> data = parseWorkingDates(responseBody);
        return data;
      } else {
        // Xử lý lỗi tại đây
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Xử lý lỗi tại đây
      print('Đã xảy ra lỗi');
    }
    throw Exception('Không thể tải danh sách');
  }

  List<DoctorWorkingDates.DT> parseWorkingDates(String responseBody) {
    final parsed = json.decode(responseBody);
    List<dynamic> dtList = parsed['DT'];

    return dtList.map((json) => DoctorWorkingDates.DT.fromJson(json)).toList();
  }

  Future<List<DoctorSchedule.DT>> fetchDoctorSchedule(
      int doctorID, int specialtyID, int doctorScheduleDate) async {
    final String baseURL = 'http://20.24.151.181:8080/api';
    String url =
        '$baseURL/doctor/get/schedule/$doctorID/$specialtyID/$doctorScheduleDate';

    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        String responseBody = response.body;
        List<DoctorSchedule.DT> schedule = parseDoctorSchedule(responseBody);
        return schedule;
      } else {
        // Xử lý lỗi tại đây
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Xử lý lỗi tại đây
      print('Đã xảy ra lỗi');
    }
    throw Exception('Không thể tải danh sách');
  }

  List<DoctorSchedule.DT> parseDoctorSchedule(String responseBody) {
    final parsed = json.decode(responseBody);
    List<dynamic> dtList = parsed['DT'];

    return dtList.map((json) => DoctorSchedule.DT.fromJson(json)).toList();
  }

  Future<List<Speciality>> getSpecialityList() async {
    final response = await http.get(
        Uri.parse('http://20.24.151.181:8080/api/doctor/get/specialtylist'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final specialityList = data['DT'] as List<dynamic>;

      return specialityList.map((item) => Speciality.fromJson(item)).toList();
    } else {
      throw Exception('Không thể tải danh sách');
    }
  }

  Future<List<ListDate>> getDateList() async {
    final response = await http
        .get(Uri.parse('http://20.24.151.181:8080/api/doctor/get/listdate'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final dateList = data['DT'] as List<dynamic>;

      return dateList.map((item) => ListDate.fromJson(item)).toList();
    } else {
      throw Exception('Không thể tải danh sách');
    }
  }

  Future<List<DoctorScheduleByDate>> getDoctorScheduleByDate(
      int doctorSpecialtyID, int doctorScheduleDate) async {
    final response = await http.get(Uri.parse(
        'http://20.24.151.181:8080/api/doctor/get/schedulebydate/$doctorSpecialtyID/$doctorScheduleDate'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final doctorSchedule_by_Date = data['DT'] as List<dynamic>;

      return doctorSchedule_by_Date
          .map((item) => DoctorScheduleByDate.fromJson(item))
          .toList();
    } else {
      throw Exception('Không thể tải danh sách');
    }
  }
}
