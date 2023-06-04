import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_consent2/student_profile.dart';
import 'package:flutter/material.dart';

import 'admininstrator_profile.dart';
import 'faculty_profile.dart';

class Administrator_event_details extends StatefulWidget {
  Administrator_event_details(
      {required this.name,
      required this.id,
      required this.date,
      required this.student,
      required this.eventStartTime,
      required this.eventEndTime,
      required this.venue,
      required this.description,
      required this.facultiesInvolved,
      required this.status,
      required this.userType,
      required this.docID});
  final String id,
      date,
      student,
      eventStartTime,
      eventEndTime,
      venue,
      description,
      name,
      status,
      userType,
      docID;
  final List<dynamic> facultiesInvolved;

  @override
  State<Administrator_event_details> createState() =>
      _Administrator_event_detailsState();
}

final _firestore = FirebaseFirestore.instance;

class _Administrator_event_detailsState
    extends State<Administrator_event_details> {
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: widget.name,
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
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
                Event_Detail_Column(
                  status: widget.status,
                  id: widget.id,
                  date: widget.date,
                  student: widget.student,
                  event_start_time: widget.eventStartTime,
                  event_end_time: widget.eventEndTime,
                  venue: widget.venue,
                  description: widget.description,
                  faculties_involved: widget.facultiesInvolved,
                  isCompleted: (widget.status == 'ADMIN ACCEPTED' ||
                          widget.status == 'COMPLETED' ||
                          widget.status == 'FINAL FACULTY ACCEPTED')
                      ? true
                      : false,
                  userType: widget.userType,
                  docID: widget.docID,
                )
              ]),
        ),
      ),
    );
  }
}

class Event_Detail_Column extends StatefulWidget {
  Event_Detail_Column(
      {required this.id,
      required this.date,
      required this.student,
      required this.event_start_time,
      required this.event_end_time,
      required this.venue,
      required this.description,
      required this.faculties_involved,
      required this.isCompleted,
      required this.status,
      required this.userType,
      required this.docID});

  final String id,
      date,
      student,
      event_start_time,
      event_end_time,
      venue,
      description,
      status,
      userType,
      docID;

  final List<dynamic> faculties_involved;
  final bool isCompleted;

  @override
  State<Event_Detail_Column> createState() => _Event_Detail_ColumnState();
}

class _Event_Detail_ColumnState extends State<Event_Detail_Column> {
  Widget _RejectButton(BuildContext context) {
    if (widget.status != 'COMPLETED') {
      return TextButton(
        onPressed: () async {
          await _firestore
              .collection('Event Request')
              .doc(widget.docID)
              .delete();

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Expanded(
                child: AlertDialog(
                  title: Text('Event Request is withdrawn succesfully'),
                  // content: Text('GeeksforGeeks'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'OK',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xfffbb448), Color(0xfff7892b)])),
          child: Text(
            'REJECT',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
    } else {
      return Text('');
    }
  }

  Widget _AdminAcceptButton(BuildContext context) {
    if (widget.status != 'COMPLETED') {
      return TextButton(
        onPressed: () async {
          final data = {"Status": 'ADMIN ACCEPTED'};
          _firestore
              .collection("Event Request")
              .doc(widget.docID)
              .set(data, SetOptions(merge: true));

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Expanded(
                child: AlertDialog(
                  title: Text('The Event Request has been Accepted'),
                  // content: Text('GeeksforGeeks'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'OK',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xfffbb448), Color(0xfff7892b)])),
          child: Text(
            'ACCEPT',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
    } else {
      return Text('');
    }
  }

  Widget bottompart(BuildContext context) {
    String currentOrFinal;
    Widget rejectButtton;
    Widget adminAcceptButton;
    if (widget.isCompleted == false) {
      currentOrFinal = 'Current Faculty :';
      rejectButtton = _RejectButton(context);
      adminAcceptButton = Text('');
    } else {
      currentOrFinal = 'Final Faculty :';
      if (widget.status != 'COMPLETED') {
        rejectButtton = _RejectButton(context);
      } else {
        rejectButtton = Text('');
      }
      if (widget.status == 'FINAL FACULTY ACCEPTED') {
        adminAcceptButton = _AdminAcceptButton(context);
      } else {
        adminAcceptButton = Text('');
      }
    }
    return Column(
      children: [
        Text(
          currentOrFinal,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Faculty_profile(
                    facultyMail: widget.faculties_involved.last.toString(),
                  ),
                ));
          },
          child: Text(
            widget.faculties_involved.last,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Colors.blueAccent),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        rejectButtton,
        SizedBox(
          height: 30,
        ),
        adminAcceptButton
      ],
    );
  }

  List<Widget> facultylist(BuildContext context) {
    List<Widget> FacultiesInvolvedList = [];

    for (dynamic faculty in widget.faculties_involved) {
      if (widget.faculties_involved.last.toString() != faculty.toString()) {
        FacultiesInvolvedList.add(TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Faculty_profile(
                    facultyMail: faculty.toString(),
                  ),
                ));
          },
          child: Text(
            faculty.toString(),
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Colors.blueAccent),
          ),
        ));
      }
    }
    return FacultiesInvolvedList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'ID : ' + widget.id,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'DATE : ' + widget.date,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'GENERATED USER : ',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        TextButton(
          onPressed: () {
            print(widget.userType);
            if (widget.userType == 'FACULTY') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Faculty_profile(
                      facultyMail: widget.student,
                    ),
                  ));
            } else if (widget.userType == 'STUDENT') {
              print('student');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Student_Profile(
                      studentMail: widget.student,
                    ),
                  ));
            } else {
              print('admin');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Administrator_profile(adminMail: widget.student)));
            }
          },
          child: Text(
            widget.student,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w800, fontSize: 20, color: Colors.blue),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'EVENT START TIME : ' + widget.event_start_time,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'EVENT END TIME : ' + widget.event_end_time,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'VENUE : ' + widget.venue,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'DESCRIPTION : ' + widget.description,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'STATUS : ' + widget.status,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'FACULTIES INVOLVED:',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          children: facultylist(
              context), //returns text widgets of all the faculties involved except the last
        ),
        SizedBox(
          height: 20,
        ),
        bottompart(
            context) //returns the last faculty current faculty/final accept giving faculty
      ],
    );
  }
}
