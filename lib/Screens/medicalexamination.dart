import 'package:flutter/material.dart';
import 'package:medbook/Model/TicketList.dart';
import 'package:medbook/Screens/home.dart';
import 'package:medbook/Screens/ticket_detail.dart';
import 'package:medbook/Service/TicketServices.dart';
import 'package:medbook/Service/UserManager.dart';

class MedicalRecord extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
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
          title: const Text('Danh sách phiếu khám'),
          centerTitle: true,
          backgroundColor: Colors.blue.shade600,
        ),
        body: ListViewPage(),
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
  List<DT> TicketListData = List.empty();
  @override
  void initState() {
    super.initState();
    TicketServices.getTicketList(UserManager().userId!).then((dataFromServer) {
      setState(() {
        TicketListData = dataFromServer;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ListView.builder(
        itemCount: TicketListData.length,
        itemBuilder: (context, index) {
          final ticketList = TicketListData[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TicketDetails(
                    ticketID: ticketList.ticketID,
                  ),
                ),
              );
            },
            child: Container(
              height: 140,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ticketList.patientName!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Bác sĩ: ${ticketList.doctorName}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Khoa: ${ticketList.specialtyName}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Trạng thái: ${_convertStatus(ticketList.ticketStatus!)}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
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

  String? _convertStatus(String? status) {
    if (status == 'Pending') {
      return 'Chưa giải quyết';
    } else {
      return 'Đã giải quyết';
    }
  }
}
