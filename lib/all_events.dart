import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_consent2/administrator_event_details.dart';
import 'package:flutter/material.dart';
import 'student_faculty_event_details.dart';

class All_events extends StatefulWidget {
  const All_events({Key? key}) : super(key: key);

  @override
  State<All_events> createState() => _All_eventsState();
}

final _firestore = FirebaseFirestore.instance;
dynamic loggedInUser;

class _All_eventsState extends State<All_events> {
  Widget _title() {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        text: 'All Events',
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
        backgroundColor: Color(0xffffffff),
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
                iconSize: 30,
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
            final eventCard = EventCard(
                eventTitle: event.data()['Event Name'],
                eventId: event.data()['ID'].toString(),
                date: event.data()['Date'],
                student: event.data()['Generated User'],
                eventstatus: event.data()['Status'],
                nextpage: Administrator_event_details(
                  status: event.data()['Status'],
                  name: event.data()['Event Name'],
                  id: event.data()['ID'].toString(),
                  date: event.data()['Date'],
                  student: event.data()['Generated User'],
                  eventStartTime: event.data()['Event Start Time'],
                  eventEndTime: event.data()['Event End Time'],
                  venue: event.data()['Venue'],
                  description: event.data()['Event Description'],
                  facultiesInvolved: event.data()['FacultIies Involved'],
                  userType: event.data()['User Type'],
                  docID: event.id,
                  reason: event.data()['Reason For Removal'],
                  rejectedUser: event.data()['Rejected User'],
                ),
                context: context);
            EventRequests.add(eventCard);
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 13),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xFFFAFAFA),
            border: Border.all(
              color: Colors.grey,
              width: 0.4,
            ),
            boxShadow: [
              BoxShadow(
                  color: Color(0x13000000),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset(0, 5)),
            ],
          ),
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
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    'ID   ' + eventId,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        date,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.man,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        student,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    eventstatus,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: calStatusColour(eventstatus)),
                  ),
                  SizedBox(
                    height: 11,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
