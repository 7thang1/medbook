import 'package:flutter/material.dart';
import 'package:medbook/Service/DoctorServices.dart';
import 'package:medbook/Model/Doctor.dart';

class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  List<Doctor> doctors = [];
  bool isLoading = false;
  int pageIndex = 0;
  int pageSize = 10;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    fetchData();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (!isLoading) {
        fetchData(); // Gọi API để tải thêm dữ liệu
      }
    }
  }

  Future<void> fetchData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      try {
        final doctorList = await DoctorServices().getDoctorList(
          doctors.length, // Vị trí bắt đầu lấy danh sách bác sĩ mới
          pageSize, // Số lượng bác sĩ cần lấy
        );

        setState(() {
          doctors.addAll(doctorList);
          pageIndex++; // Tăng trang hiện tại
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print('Đã xảy ra lỗi: $e');
      }
    }
  }

  String convertToVietnameseDay(String day) {
    switch (day) {
      case 'Monday':
        return 'Thứ Hai';
      case 'Tuesday':
        return 'Thứ Ba';
      case 'Wednesday':
        return 'Thứ Tư';
      case 'Thursday':
        return 'Thứ Năm';
      case 'Friday':
        return 'Thứ Sáu';
      case 'Saturday':
        return 'Thứ Bảy';
      case 'Sunday':
        return 'Chủ Nhật';
      default:
        return day;
    }
  }

  String formatPrice(String price) {
    return price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách bác sĩ'),
        centerTitle: true,
      ),
      body: ListView.builder(
        controller: scrollController,
        itemCount: doctors.length + 1,
        itemBuilder: (context, index) {
          if (index < doctors.length) {
            final doctor = doctors[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context, doctor);
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-vector/hand-drawn-doctor-answer-questions-clipart-gesture-character_40876-3115.jpg?w=826&t=st=1688312575~exp=1688313175~hmac=c395d30569a5727c1109a2350a3b4b288f4c31e7dc13077f88696ebeecaf74bd'),
                    ),
                    title: Text(
                      doctor.doctorFullname,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chuyên khoa: ${doctor.specialtyName}',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Ngày làm việc: ${convertToVietnameseDay(doctor.workDay)}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Giá: ${formatPrice(doctor.specialtyPrice)}VNĐ',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
