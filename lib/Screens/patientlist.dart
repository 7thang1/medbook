import 'package:flutter/material.dart';
import 'package:medbook/Model/Patient.dart';
import 'package:medbook/Screens/home.dart';
import 'package:medbook/Screens/newinfo.dart';
import 'package:medbook/Screens/patientinfo.dart';
import 'package:medbook/Service/PatientServices.dart';
import 'package:medbook/Service/UserManager.dart';

class ListInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              width: 40,
              height: 40,
              child: IconButton(
                  onPressed: () => onCreatePatient(context),
                  icon: Image.asset('assets/add.png')),
            )
          ],
          leading: BackButton(
            color: Colors.white,
            onPressed: () => {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(-3, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return Home();
                  },
                ),
              ),
            },
          ),
          title: const Text('Danh sách hồ sơ'),
          centerTitle: true,
          backgroundColor: Colors.blue.shade600,
        ),
        body: ListViewPage(),
      ),
    );
  }

  void onCreatePatient(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return NewPatient();
        },
      ),
    );
  }
}

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  List<Patient> PatientData = List.empty();
  @override
  void initState() {
    super.initState();
    PatientServices.getPatientList(UserManager().userId!)
        .then((dataFromServer) {
      setState(() {
        PatientData = dataFromServer;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: PatientData.length,
        itemBuilder: (context, index) {
          final patient = PatientData[index];
          return GestureDetector(
            onTap: () {
              // Xử lý sự kiện khi nhấn vào Card
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PatientInfo(patient: patient),
                ),
              );
            },
            child: Container(
              height: 120,
              child: Card(
                child: ListTile(
                  title: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 22,
                          height: 22,
                          child: Image.asset('assets/user.png')),
                      Text(
                        patient.fullName!,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade600),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Image.asset('assets/phone.png'),
                              width: 18,
                              height: 18,
                            ),
                            Text(
                              'Số điện thoại: ${patient.phoneNumber}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Image.asset('assets/location.png'),
                              width: 18,
                              height: 18,
                            ),
                            Flexible(
                              child: Container(
                                child: Text(
                                  'Địa chỉ: ${patient.address}',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
