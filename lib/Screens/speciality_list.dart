import 'package:flutter/material.dart';
import 'package:medbook/Service/DoctorServices.dart';
import 'package:medbook/Model/Speciality.dart';

class SpecialityList extends StatefulWidget {
  @override
  _SpecialityListState createState() => _SpecialityListState();
}

class _SpecialityListState extends State<SpecialityList> {
  List<Speciality> specialities = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final specialityList = await DoctorServices().getSpecialityList();
    setState(() {
      specialities = specialityList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách chuyên khoa'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: specialities.length,
        itemBuilder: (context, index) {
          final speciality = specialities[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context, speciality);
              },
              child: Container(
                  height: 80,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(speciality.name),
                      ),
                      Text('${formatPrice(speciality.price)} VNĐ'),
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }

  String formatPrice(String price) {
    return price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
        );
  }
}
