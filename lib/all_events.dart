import 'package:flutter/material.dart';
import 'student_event_details.dart';

class All_events extends StatefulWidget {
  const All_events({Key? key}) : super(key: key);

  @override
  State<All_events> createState() => _All_eventsState();
}

class _All_eventsState extends State<All_events> {
  Widget _title() {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        text: 'ALL EVENTS',
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10)),
      ),
    );
  }

  String? _selectedOption = 'ALL';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0x0ff3892b),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(15, 40, 0, 30),
                  child: _title(),
                  width: double.infinity,
                ),
                DropdownButton<String>(
                  //isExpanded: true,
                  iconEnabledColor: Color(0xfff7892b),
                  iconSize: 60,
                  value: _selectedOption,
                  items: <String>[
                    'ALL',
                    'ADMIN ACCEPTED',
                    'ONGOING',
                    'REJECTED',
                    'FINAL ACCEPT RECEIVED',
                    'COMPLETED'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // Change function parameter to nullable string
                    setState(() {
                      _selectedOption = newValue;
                    });
                  },
                ),
                EventCard(
                  eventTitle: 'Flutter Workshop',
                  eventId: '101',
                  date: '01 NOV 23',
                  student: 'Akash',
                  eventstatus: 'ADMIN ACCEPTED',
                  nextpage: Student_event_details(),
                ),
                EventCard(
                  eventTitle: 'Soft Skill ',
                  eventId: '200',
                  date: '24 SEP 23',
                  student: 'Manu',
                  eventstatus: 'ONGOING',
                  nextpage: Student_event_details(),
                ),
                EventCard(
                  eventTitle: 'Django Workshop ',
                  eventId: '201',
                  date: '24 DEC 23',
                  student: 'Thara',
                  eventstatus: 'REJECTED',
                  nextpage: Student_event_details(),
                ),
                EventCard(
                  eventTitle: 'Literary Fezt',
                  eventId: '211',
                  date: '24 MAR 23',
                  student: 'Akshay',
                  eventstatus: 'FINAL ACCEPT RECEIVED',
                  nextpage: Student_event_details(),
                ),
                EventCard(
                  eventTitle: 'Movie Fezt ',
                  eventId: '300',
                  date: '01 JAN 23',
                  student: 'KS',
                  eventstatus: 'COMPLETED',
                  nextpage: Student_event_details(),
                ),
                EventCard(
                  eventTitle: 'Soft Skill ',
                  eventId: '200',
                  date: '24 SEP 23',
                  student: 'Manu',
                  eventstatus: 'ONGOING',
                  nextpage: Student_event_details(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  EventCard(
      {required this.eventTitle,
      required this.eventId,
      required this.date,
      required this.student,
      required this.eventstatus,
      required this.nextpage});
  String eventTitle;
  String eventId;
  String date;
  String student;
  String eventstatus;
  Widget nextpage;

  Color calStatusColour(String eventstatus) {
    if (eventstatus == 'ADMIN ACCEPTED') {
      return Colors.green;
    } else if (eventstatus == 'ONGOING') {
      return Colors.blue;
    } else if (eventstatus == 'REJECTED') {
      return Colors.red;
    } else if (eventstatus == 'FINAL ACCEPT RECEIVED') {
      return Colors.greenAccent;
    } else {
      return Colors.black38;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => nextpage,
            ));
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  eventTitle,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  'Id : ' + eventId,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  'Date : ' + date,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  'Student : ' + student,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            Expanded(child: Container()),
            Expanded(
              child: Text(
                textAlign: TextAlign.center,
                eventstatus,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: calStatusColour(eventstatus)),
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }
}
