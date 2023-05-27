import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_consent2/student_event_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Pending_events extends StatefulWidget {
  const Pending_events({Key? key}) : super(key: key);

  @override
  State<Pending_events> createState() => _Pending_eventsState();
}

final _firestore = FirebaseFirestore.instance;
dynamic loggedInUser;

class _Pending_eventsState extends State<Pending_events> {
  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

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
              MessageStream()
            ],
          ),
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore.collection('Event Request').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final events = snapshot.data?.docs.reversed;
          List<EventCard> EventRequests = [];
          for (var event in events!) {
            // final messageText = message.data()['text'];
            // final messageSender = message.data()['sender'];
            // List facultiesInvolved = event.data()['Faculties Involved'];
            if (loggedInUser.email ==
                event.data()['FacultIies Involved'].last) {
              final eventCard = EventCard(
                  eventTitle: event.data()['Event Name'],
                  eventId: event.data()['ID'].toString(),
                  date: event.data()['Date'],
                  student: event.data()['Generated User'],
                  eventstatus: 'ONGOING',
                  nextpage: Student_event_details(
                      name: event.data()['Event Name'],
                      id: event.data()['ID'].toString(),
                      date: event.data()['Date'],
                      student: event.data()['Generated User'],
                      eventStartTime: event.data()['Event Start Time'],
                      eventEndTime: event.data()['Event End Time'],
                      venue: event.data()['Venue'],
                      description: event.data()['Event Description'],
                      facultiesInvolved: event.data()['FacultIies Involved']),
                  context: context);
              EventRequests.add(eventCard);
            }
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
              children: EventRequests,
            ),
          );
        });
  }
}

class EventCard extends StatelessWidget {
  EventCard(
      {required this.eventTitle,
      required this.eventId,
      required this.date,
      required this.student,
      required this.eventstatus,
      required this.nextpage,
      required BuildContext context});
  final String eventTitle;
  final String eventId;
  final String date;
  final String student;
  final String eventstatus;
  final Widget nextpage;

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
