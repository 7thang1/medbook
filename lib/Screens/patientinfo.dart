import 'package:flutter/material.dart';
import 'package:medbook/Model/Patient.dart';
import 'package:medbook/Screens/booking_by_date.dart';
import 'package:medbook/Screens/booking_by_doctor.dart';

class PatientInfo extends StatelessWidget {
  final Patient patient;

  const PatientInfo({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text('Thông tin bệnh nhân'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                editPatient(context);
              } else if (value == 'delete') {
                deletePatient(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Container(
                          height: 20,
                          width: 20,
                          child: Image.asset('assets/edit.png')),
                      SizedBox(width: 8),
                      Text('Chỉnh sửa'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Container(
                          width: 20,
                          height: 20,
                          child: Image.asset('assets/delete.png')),
                      SizedBox(width: 8),
                      Text('Xóa'),
                    ],
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 600,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoItem('Họ và tên', patient.fullName ?? 'Chưa cập nhật'),
              _buildDivider(),
              _buildDateOfBirthItem('Ngày sinh', patient.dateOfBirth),
              _buildDivider(),
              _buildInfoItem('Giới tính',
                  _convertGender(patient.gender) ?? 'Chưa cập nhật'),
              _buildDivider(),
              _buildInfoItem(
                  'Số điện thoại', patient.phoneNumber ?? 'Chưa cập nhật'),
              SizedBox(height: 8),
              _buildDivider(),
              _buildInfoItem('Địa chỉ', patient.address ?? 'Chưa cập nhật',
                  isAddress: true),
              _buildDivider(),
              _buildInfoItem(
                  'Nghề nghiệp', patient.occupation ?? 'Chưa cập nhật'),
              _buildDivider(),
              _buildInfoItem('Dân tộc', patient.ethnicity ?? 'Chưa cập nhật'),
            ],
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(left: 26),
          child: ElevatedButton(
            onPressed: () {
              showBookingOptions(context);
            },
            child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/stethoscope.png', width: 24, height: 24),
                  SizedBox(width: 8),
                  Text(
                    'Đặt lịch khám',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              elevation: MaterialStateProperty.all<double>(4),
              textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String value, {bool isAddress = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey.shade400,
      thickness: 1,
      height: 16,
    );
  }

  Widget _buildDateOfBirthItem(String title, String? dateOfBirth) {
    String formattedDateOfBirth = 'Chưa cập nhật';
    if (dateOfBirth != null) {
      List<String> dateParts = dateOfBirth.split('-');
      if (dateParts.length == 3) {
        String day = dateParts[2];
        String month = dateParts[1];
        String year = dateParts[0];
        formattedDateOfBirth = '$day/$month/$year';
      }
    }

    return _buildInfoItem(title, formattedDateOfBirth);
  }

  void editPatient(BuildContext context) {}

  void deletePatient(BuildContext context) {}
  void showBookingOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BookingByDoctor(patient: patient)));
                },
                leading: Icon(
                  Icons.person,
                  color: Colors.blue,
                  size: 32,
                ),
                title: Text(
                  'Đặt lịch theo bác sĩ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BookingByDates(patient: patient)));
                },
                leading: Icon(
                  Icons.calendar_today,
                  color: Colors.blue,
                  size: 32,
                ),
                title: Text(
                  'Đặt lịch theo ngày',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String? _convertGender(String? gender) {
    if (gender == 'Male') {
      return 'Nam';
    } else if (gender == 'Female') {
      return 'Nữ';
    }
    return 'Khác';
  }
}
