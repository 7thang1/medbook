import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:medbook/Model/Patient.dart';

class PatientServices {
  static const String url = 'http://20.24.151.181:8080/api/patient/get/list/';

  static List<Patient> parsePatient(String responseBody) {
    final parsed = jsonDecode(responseBody) as List<dynamic>;
    List<Patient> patients =
        parsed.map((Model) => Patient.fromJson(Model)).toList();
    return patients;
  }

  static Future<List<Patient>> getPatientList(int userId) async {
    final response = await http.get(Uri.parse(url + userId.toString()));
    if (response.statusCode == 200) {
      return compute((parsePatient), response.body);
    } else {
      throw Exception('Unable to fetch patient from the REST API');
    }
  }
}
