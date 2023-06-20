import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_consent2/pending_event_details.dart';
import 'package:event_consent2/student_faculty_event_details.dart';
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

  var admins, students, faculties;

  void getData() async {
    var admins1 =
        await _firestore.collection("Administrator User Details").get();
    var faculties1 = await _firestore.collection("Faculty User Details").get();
    var students1 = await _firestore.collection("Student User Details").get();
    setState(() {
      admins = admins1;
      faculties = faculties1;
      students = students1;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getData();
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

  String _searchText = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    // style: ,
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                    decoration: InputDecoration(
                        focusColor: Colors.grey,
                        contentPadding: EdgeInsets.zero,
                        hintText: "Search",
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(width: 4)),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 15,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MessageStream(
                searchText: _searchText,
                students: students,
                faculties: faculties,
                admins: admins,
              )
            ],
          ),
        ),
      ),
    );
  }
}

String generatedUserName(
    String type, String mail, var admins, var faculties, var students) {
  if (admins != null && faculties != null && students != null) {
    if (type == 'ADMINISTRATOR') {
      for (var admin in admins.docs) {
        if (admin.data()['Email'] == mail) {
          return admin.data()['Name'];
        }
      }
    } else if (type == 'FACULTY') {
      for (var faculty in faculties.docs) {
        if (faculty.data()['Email'] == mail) {
          return faculty.data()['Name'];
        }
      }
    } else if (type == 'STUDENT') {
      for (var student in students.docs) {
        if (student.data()['Email'] == mail) {
          return student.data()['Name'];
        }
      }
    }
    return '';
  } else {
    return '';
  }
}

class MessageStream extends StatelessWidget {
  MessageStream(
      {required this.searchText,
      required this.students,
      required this.faculties,
      required this.admins});
  final String searchText;
  var students, faculties, admins;
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
            if ((loggedInUser.email ==
                    event.data()['FacultIies Involved'].last) &&
                (event.data()['Status'] == 'ONGOING') &&
                (event
                        .data()['Event Name']
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ||
                    event
                        .data()['ID']
                        .toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ||
                    event
                        .data()['Date']
                        .toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase()) ||
                    event
                        .data()['Generated User']
                        .toLowerCase()
                        .contains(searchText.toLowerCase()))) {
              final eventCard = EventCard(
                  eventTitle: event.data()['Event Name'],
                  eventId: event.data()['ID'].toString(),
                  date: event.data()['Date'],
                  student: generatedUserName(
                      event.data()['User Type'],
                      event.data()['Generated User'],
                      admins,
                      faculties,
                      students),
                  eventstatus: 'ONGOING',
                  nextpage: Pending_Event_Details(
                    eventDocumentID: event.id,
                  ),
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
