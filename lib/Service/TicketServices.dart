import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medbook/Model/TicketList.dart' as TicketList;
import 'package:medbook/Model/Ticket.dart' as Ticket;

class TicketServices {
  static const String baseUrl = 'http://20.24.151.181:8080/api';

  Future<Map<String, dynamic>> createTicket(
      int patientID,
      int doctorID,
      int doctorSpecialtyID,
      int doctorRoomID,
      int dateID,
      int timeslotID) async {
    final url = '$baseUrl/ticket/create';
    final body = jsonEncode({
      'patientID': patientID,
      'doctorID': doctorID,
      'doctorSpecialtyID': doctorSpecialtyID,
      'doctorRoomID': doctorRoomID,
      'dateID': dateID,
      'timeslotID': timeslotID,
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
            'message': 'Tạo phiếu thành công',
          };
        } else {
          // Login failed
          return {
            'success': false,
            'message': 'Tạo phiếu thất bại',
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

  static Future<List<TicketList.DT>> getTicketList(int userID) async {
    String url =
        'http://20.24.151.181:8080/api/ticket/get/informticket/user/$userID';
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String respnseBody = response.body;
        List<TicketList.DT> TicketData = parseTicketList(respnseBody);
        return TicketData;
      } else {
        throw Exception('Không thể tải phiếu khám');
      }
    } catch (e) {
      throw Exception('Đã xảy ra lỗi khi tải phiếu');
    }
  }

  static List<TicketList.DT> parseTicketList(String responseBody) {
    final parsed = jsonDecode(responseBody);
    List<dynamic> dtList = parsed['DT'];
    return dtList.map((json) => TicketList.DT.fromJson(json)).toList();
  }

  static Future<List<Ticket.DT>> getTicketDetails(int ticketID) async {
    String url =
        'http://20.24.151.181:8080/api/ticket/get/informticket/$ticketID';
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String respnseBody = response.body;
        List<Ticket.DT> TicketDetails = parseTicketDetails(respnseBody);

        return TicketDetails;
      } else {
        throw Exception('Không thể tải phiếu khám');
      }
    } catch (e) {
      throw Exception('Đã xảy ra lỗi khi tải phiếu');
    }
  }

  static List<Ticket.DT> parseTicketDetails(String responseBody) {
    final parsed = jsonDecode(responseBody);
    List<dynamic> dtList = parsed['DT'];
    return dtList.map((json) => Ticket.DT.fromJson(json)).toList();
  }
}
