import 'package:flutter/material.dart';
import 'pending_event_details.dart';

class Pending_events extends StatefulWidget {
  const Pending_events({Key? key}) : super(key: key);

  @override
  State<Pending_events> createState() => _Pending_eventsState();
}

class _Pending_eventsState extends State<Pending_events> {
  Widget _title() {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        text: 'Pending Events',
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
                    'DATE AND TIME VERIFIED',
                    'DATE AND TIME NOT VERIFIED',
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
                  eventstatus: 'DATE AND TIME VERIFIED',
                  nextpage: Pending_Event_Details(),
                ),
                EventCard(
                  eventTitle: 'Soft Skill ',
                  eventId: '200',
                  date: '24 SEP 23',
                  student: 'Manu',
                  eventstatus: 'DATE AND TIME VERIFIED',
                  nextpage: Pending_Event_Details(),
                ),
                EventCard(
                  eventTitle: 'Django Workshop ',
                  eventId: '201',
                  date: '24 DEC 23',
                  student: 'Thara',
                  eventstatus: 'DATE AND TIME VERIFIED',
                  nextpage: Pending_Event_Details(),
                ),
                EventCard(
                  eventTitle: 'Literary Fezt',
                  eventId: '211',
                  date: '24 MAR 23',
                  student: 'Akshay',
                  eventstatus: 'DATE AND TIME NOT VERIFIED',
                  nextpage: Pending_Event_Details(),
                ),
                EventCard(
                  eventTitle: 'Movie Fezt ',
                  eventId: '300',
                  date: '01 JAN 23',
                  student: 'KS',
                  eventstatus: 'DATE AND TIME NOT VERIFIED',
                  nextpage: Pending_Event_Details(),
                ),
                EventCard(
                  eventTitle: 'Soft Skill ',
                  eventId: '200',
                  date: '24 SEP 23',
                  student: 'Manu',
                  eventstatus: 'DATE AND TIME VERIFIED',
                  nextpage: Pending_Event_Details(),
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
    if (eventstatus == 'DATE AND TIME VERIFIED') {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
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
