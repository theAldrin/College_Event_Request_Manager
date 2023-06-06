import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_consent2/admininstrator_profile.dart';
import 'package:event_consent2/student_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'faculty_profile.dart';

dynamic loggedInUser;

class Student_Faculty_event_details extends StatefulWidget {
  Student_Faculty_event_details(
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
      required this.reason,
      required this.rejectedUser});
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
      reason,
      rejectedUser;
  final List<dynamic> facultiesInvolved;

  @override
  State<Student_Faculty_event_details> createState() =>
      _Student_Faculty_event_detailsState();
}

final _firestore = FirebaseFirestore.instance;

class _Student_Faculty_event_detailsState
    extends State<Student_Faculty_event_details> {
  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
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
                  reason: widget.reason,
                  rejectedUser: widget.rejectedUser,
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
      required this.reason,
      required this.rejectedUser});

  final String id,
      date,
      student,
      event_start_time,
      event_end_time,
      venue,
      description,
      status,
      userType,
      reason,
      rejectedUser;

  final List<dynamic> faculties_involved;
  final bool isCompleted;

  @override
  State<Event_Detail_Column> createState() => _Event_Detail_ColumnState();
}

String docID = '';

class _Event_Detail_ColumnState extends State<Event_Detail_Column> {
  late String newReason;

  Widget _RequestWithdrawButton(BuildContext context) {
    if (widget.status != 'COMPLETED' && loggedInUser.email == widget.student) {
      return TextButton(
        onPressed: () async {
          final eventData = await _firestore.collection('Event Request').get();
          final events = eventData.docs;
          for (var event in events) {
            if (event.data()['ID'].toString() == widget.id) {
              docID = event.id;
            }
          }
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 30),
              child: Container(
                color: Color(0xFF757575),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  padding: EdgeInsets.fromLTRB(40, 30, 40, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reason',
                        style: TextStyle(
                            color: Color(0xffe46b10),
                            fontSize: 35,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autofocus: true,
                        style: TextStyle(fontSize: 15),
                        maxLines: 250,
                        minLines: 1,
                        onChanged: (value) {
                          newReason = value;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.5),
                          ),
                          focusColor: Colors.grey,
                          contentPadding: EdgeInsets.all(12),
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(width: 0.5)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.black,
                        ),
                        child: TextButton(
                            onPressed: () {
                              final data = {
                                "Status": 'WITHDRAWN',
                                "Reason For Removal": newReason
                              };
                              _firestore
                                  .collection("Event Request")
                                  .doc(docID)
                                  .set(data, SetOptions(merge: true));
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text(
                              'CONFIRM',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            )),
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
            'WITHDRAW REQUEST',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
    } else {
      return Text('');
    }
  }

  Widget bottompart(BuildContext context) {
    String currentOrFinal = '';
    Widget lastButton;
    if (widget.status == 'ONGOING') {
      currentOrFinal = 'Current Faculty :';
      lastButton = _RequestWithdrawButton(context);
    } else if (widget.status == 'FINAL FACULTY ACCEPTED' ||
        widget.status == 'ADMIN ACCEPTED') {
      currentOrFinal = 'Final Accept By :';
      lastButton = _RequestWithdrawButton(context);
    } else {
      lastButton = Text('');
    }

    return Column(
      children: [
        Text(
          currentOrFinal,
          textAlign: (currentOrFinal != '') ? TextAlign.center : null,
          style: (currentOrFinal != '')
              ? TextStyle(fontWeight: FontWeight.w900, fontSize: 30)
              : null,
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
        lastButton,
        SizedBox(
          height: 30,
        )
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

  Widget reasonText() {
    if (widget.status == 'WITHDRAWN') {
      return Text(
        'REASON : ' + widget.reason,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
      );
    } else if (widget.status == 'REJECTED') {
      return Column(
        children: [
          Text(
            'REJECTED BY : ' + widget.rejectedUser,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'REASON : ' + widget.reason,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
          ),
        ],
      );
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              offset: Offset(0, 0)),
        ],
      ),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Column(
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
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: Colors.blue),
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
          reasonText(),
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
      ),
    );
  }
}
