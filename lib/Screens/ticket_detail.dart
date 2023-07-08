import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/services.dart';
import 'package:medbook/Service/TicketServices.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:medbook/Model/Ticket.dart' as Ticket;

class TicketDetails extends StatefulWidget {
  final int? ticketID;
  const TicketDetails({required this.ticketID});
  @override
  _TicketDetailsState createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  List<Ticket.DT> TicketDetailsData = List.empty();
  Ticket.DT? _ticketdetails;

  @override
  void initState() {
    super.initState();
    TicketServices.getTicketDetails(widget.ticketID!).then((dataFromServer) {
      setState(() {
        TicketDetailsData = dataFromServer;
        _ticketdetails = TicketDetailsData[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade500,
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: Text(
                'Phiếu khám bệnh'.toUpperCase(),
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: TicketWidget(
                  width: 400,
                  height: 600,
                  isCornerRounded: true,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.greenAccent.shade400,
                                        width: 1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Khám dịch vụ',
                                      style: TextStyle(
                                        color: Colors.greenAccent.shade400,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'MedBook'.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Image.asset(
                                        'assets/LOG7.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/hospital.png',
                                      width: 30,
                                      height: 30,
                                      color: Colors.blue.shade600,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Bệnh viện ABC',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue.shade600,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ticketDetailsWidget('Bệnh nhân',
                                  '${_ticketdetails?.patientName}'),
                              ticketDetailsWidget(
                                  'Ngày khám', '${_ticketdetails?.placedDate}'),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 28, right: 26),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ticketDetailsWidget(
                                    'Mã phiếu', '${_ticketdetails?.ticketID}'),
                                ticketDetailsWidget(
                                    'Giờ khám', '${_ticketdetails?.timeslot}'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 28, right: 34),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ticketDetailsWidget('Giá',
                                    '${formatPrice(_ticketdetails?.ticketPrice)}VNĐ'),
                                ticketDetailsWidget('Phòng khám',
                                    '${_ticketdetails?.roomName}'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                            height: 100,
                            width: 250,
                            child: BarcodeWidget(
                                data: String.fromCharCode(widget.ticketID!),
                                barcode: Barcode.code128()),
                          )
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget ticketDetailsWidget(String title, String details) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              )),
          SizedBox(
            height: 5,
          ),
          Text(
            details,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      );
  String formatPrice(String? price) {
    if (price != null) {
      return price.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]}.',
      );
    }
    return '';
  }
}
