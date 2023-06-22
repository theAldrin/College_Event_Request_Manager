import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_consent2/student_profile.dart';
import 'package:flutter/material.dart';

import 'admininstrator_profile.dart';
import 'faculty_profile.dart';

class Administrator_event_details extends StatefulWidget {
  Administrator_event_details({required this.docId});

  final String docId;

  @override
  State<Administrator_event_details> createState() =>
      _Administrator_event_detailsState();
}

final _firestore = FirebaseFirestore.instance;

class _Administrator_event_detailsState
    extends State<Administrator_event_details> {
  String id = ' ',
      date = ' ',
      student = ' ',
      eventStartTime = ' ',
      eventEndTime = ' ',
      venue = ' ',
      description = ' ',
      name = ' ',
      status = ' ',
      userType = ' ',
      docID = ' ',
      reason = ' ',
      rejectedUser = ' ';
  List<dynamic> facultiesInvolved = [' '];

  void getDetails() async {
    final event =
        await _firestore.collection("Event Request").doc(widget.docId).get();
    setState(() {
      id = event.data()!['ID'].toString();
      date = event.data()?['Date'];
      student = event.data()?['Generated User'];
      eventStartTime = event.data()?['Event Start Time'];
      eventEndTime = event.data()?['Event End Time'];
      venue = event.data()?['Venue'];
      description = event.data()?['Event Description'];
      name = event.data()?['Event Name'];
      status = event.data()?['Status'];
      userType = event.data()?['User Type'];
      docID = event.id;
      reason = event.data()?['Reason For Removal'];
      rejectedUser = event.data()?['Rejected User'];
      facultiesInvolved = event.data()?['FacultIies Involved'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black54,
                        ))
                  ],
                ),
                // Container(
                //   margin: EdgeInsets.fromLTRB(15, 10, 0, 30),
                //   child: _title(),
                //   width: double.infinity,
                // ),
                Event_Detail_Column(
                  status: status,
                  id: id,
                  date: date,
                  student: student,
                  event_start_time: eventStartTime,
                  event_end_time: eventEndTime,
                  venue: venue,
                  description: description,
                  faculties_involved: facultiesInvolved,
                  isCompleted: (status == 'ADMIN ACCEPTED' ||
                          status == 'COMPLETED' ||
                          status == 'FINAL FACULTY ACCEPTED')
                      ? true
                      : false,
                  userType: userType,
                  docID: docID,
                  reason: reason,
                  rejectedUser: rejectedUser,
                  name: name,
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
      required this.docID,
      required this.reason,
      required this.rejectedUser,
      required this.name});

  final String id,
      date,
      student,
      event_start_time,
      event_end_time,
      venue,
      description,
      status,
      userType,
      docID,
      reason,
      rejectedUser,
      name;

  final List<dynamic> faculties_involved;
  final bool isCompleted;

  @override
  State<Event_Detail_Column> createState() => _Event_Detail_ColumnState();
}

String newReason = '';

class _Event_Detail_ColumnState extends State<Event_Detail_Column> {
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

  Widget _RejectButton(BuildContext context) {
    if (widget.status != 'COMPLETED') {
      return TextButton(
        onPressed: () async {
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
                            onPressed: () async {
                              String adminMail = ' ';
                              final admins = await _firestore
                                  .collection("Administrator User Details")
                                  .get();
                              for (var admin in admins.docs) {
                                adminMail = admin.data()['Email'];
                              }
                              final data = {
                                "Status": 'REJECTED',
                                "Reason For Removal": newReason,
                                "Rejected User": adminMail
                              };
                              _firestore
                                  .collection("Event Request")
                                  .doc(widget.docID)
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
                  colors: [Colors.black87, Colors.black87])),
          child: Text(
            'REJECT',
            style: TextStyle(fontSize: 15, color: Colors.white),
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
                  colors: [Colors.black87, Colors.black87])),
          child: Text(
            'ACCEPT',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      );
    } else {
      return Text('');
    }
  }

  Widget rejectButtton = Container();
  Widget adminAcceptButton = Container();

  Widget bottompart(BuildContext context) {
    String currentOrFinal = ' ';

    if (widget.status == 'ONGOING') {
      currentOrFinal = 'Current Faculty :';
      setState(() {
        rejectButtton = _RejectButton(context);
      });
    } else if (widget.status == 'FINAL FACULTY ACCEPTED') {
      currentOrFinal = 'Final Faculty :';
      setState(() {
        rejectButtton = _RejectButton(context);
        adminAcceptButton = _AdminAcceptButton(context);
      });
    } else if (widget.status == 'ADMIN ACCEPTED') {
      currentOrFinal = 'Final Faculty :';
      setState(() {
        rejectButtton = _RejectButton(context);
      });
    } else {}
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Faculty_profile(
                    facultyMail: widget.faculties_involved.last.toString(),
                  ),
                ));
          },
          child: Row(
            children: [
              Text(
                widget.faculties_involved.last,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: Colors.blueAccent),
              ),
              Text(
                ' -> ' + currentOrFinal,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: Colors.black54),
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 20,
        // ),
        // rejectButtton,
        // SizedBox(
        //   height: 30,
        // ),
        // adminAcceptButton
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
                fontSize: 15,
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
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
      );
    } else if (widget.status == 'REJECTED') {
      return Column(
        children: [
          Text(
            'REJECTED BY : ' + widget.rejectedUser,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'REASON : ' + widget.reason,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Color calStatusColour(String eventstatus) {
    if (eventstatus == 'ADMIN ACCEPTED') {
      return Colors.green;
    } else if (eventstatus == 'ONGOING') {
      return Colors.blue;
    } else if (eventstatus == 'REJECTED' || eventstatus == 'WITHDRAWN') {
      return Colors.red;
    } else if (eventstatus == 'FINAL FACULTY ACCEPTED') {
      return Colors.greenAccent;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 45),
      width: double.infinity,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(15),
      //   color: Color(0xFFFAFAFA),
      //   // border: Border.all(
      //   //   color: Colors.grey,
      //   //   width: 0.4,
      //   // ),
      //   boxShadow: [
      //     BoxShadow(
      //         color: Color(0x2f000000),
      //         blurRadius: 5,
      //         spreadRadius: 1,
      //         offset: Offset(0, 0)),
      //   ],
      // ),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(8, 0, 0, 30),
            child: _title(),
            width: double.infinity,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xFFFAFAFA),
                      // border: Border.all(
                      //   color: Colors.grey,
                      //   width: 0.4,
                      // ),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x2f000000),
                            blurRadius: 5,
                            spreadRadius: 1,
                            offset: Offset(0, 0)),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ID : ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              widget.id,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 17,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'APPLICANT : ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 15),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        GestureDetector(
                          onTap: () {
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
                                          Administrator_profile(
                                              adminMail: widget.student)));
                            }
                          },
                          child: Text(
                            widget.student,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 94,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xFFFAFAFA),
                      // border: Border.all(
                      //   color: Colors.grey,
                      //   width: 0.4,
                      // ),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x2f000000),
                            blurRadius: 5,
                            spreadRadius: 1,
                            offset: Offset(0, 0)),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.date_range),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              '   ' + widget.date,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.access_time_filled),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              '${widget.event_start_time} - ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  color: Colors.black54),
                            ),
                            Text(
                              widget.event_end_time,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xFFFAFAFA),
                // border: Border.all(
                //   color: Colors.grey,
                //   width: 0.4,
                // ),
                boxShadow: [
                  BoxShadow(
                      color: Color(0x2f000000),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(0, 0)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                  ),
                  Text(
                    'DESCRIPTION',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xFFFAFAFA),
                      // border: Border.all(
                      //   color: Colors.grey,
                      //   width: 0.4,
                      // ),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x2f000000),
                            blurRadius: 5,
                            spreadRadius: 1,
                            offset: Offset(0, 0)),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'VENUE : ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 15),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          widget.venue,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xFFFAFAFA),
                      // border: Border.all(
                      //   color: Colors.grey,
                      //   width: 0.4,
                      // ),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x2f000000),
                            blurRadius: 5,
                            spreadRadius: 1,
                            offset: Offset(0, 0)),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'STATUS : ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 15),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          widget.status,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: calStatusColour(widget.status)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFFAFAFA),
                        // border: Border.all(
                        //   color: Colors.grey,
                        //   width: 0.4,
                        // ),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x2f000000),
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: Offset(0, 0)),
                        ],
                      ),
                      child: reasonText()),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xFFFAFAFA),
                // border: Border.all(
                //   color: Colors.grey,
                //   width: 0.4,
                // ),
                boxShadow: [
                  BoxShadow(
                      color: Color(0x2f000000),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(0, 0)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FACULTIES INVOLVED',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: facultylist(
                        context), //returns text widgets of all the faculties involved except the last
                  ),
                  bottompart(context)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          SizedBox(
            height: 20,
          ),
          rejectButtton,
          SizedBox(
            height: 30,
          ),
          adminAcceptButton //returns the last faculty current faculty/final accept giving faculty
        ],
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:event_consent2/student_profile.dart';
// import 'package:flutter/material.dart';
//
// import 'admininstrator_profile.dart';
// import 'faculty_profile.dart';
//
// class Administrator_event_details extends StatefulWidget {
//   Administrator_event_details(
//       {required this.name,
//         required this.id,
//         required this.date,
//         required this.student,
//         required this.eventStartTime,
//         required this.eventEndTime,
//         required this.venue,
//         required this.description,
//         required this.facultiesInvolved,
//         required this.status,
//         required this.userType,
//         required this.docID,
//         required this.reason,
//         required this.rejectedUser});
//   final String id,
//       date,
//       student,
//       eventStartTime,
//       eventEndTime,
//       venue,
//       description,
//       name,
//       status,
//       userType,
//       docID,
//       reason,
//       rejectedUser;
//   final List<dynamic> facultiesInvolved;
//
//   @override
//   State<Administrator_event_details> createState() =>
//       _Administrator_event_detailsState();
// }
//
// final _firestore = FirebaseFirestore.instance;
//
// class _Administrator_event_detailsState
//     extends State<Administrator_event_details> {
//   Widget _title() {
//     return RichText(
//       textAlign: TextAlign.center,
//       text: TextSpan(
//         text: widget.name,
//         style: TextStyle(
//             fontSize: 40,
//             fontWeight: FontWeight.w700,
//             color: Color(0xffe46b10)),
//       ),
//     );
//   }
//
//   // void getDetails() async {
//   //   final event = await _firestore
//   //       .collection("Event Request")
//   //       .doc(widget.eventDocumentID)
//   //       .get();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffffffff),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.fromLTRB(15, 40, 0, 30),
//                   child: _title(),
//                   width: double.infinity,
//                 ),
//                 Event_Detail_Column(
//                   status: widget.status,
//                   id: widget.id,
//                   date: widget.date,
//                   student: widget.student,
//                   event_start_time: widget.eventStartTime,
//                   event_end_time: widget.eventEndTime,
//                   venue: widget.venue,
//                   description: widget.description,
//                   faculties_involved: widget.facultiesInvolved,
//                   isCompleted: (widget.status == 'ADMIN ACCEPTED' ||
//                       widget.status == 'COMPLETED' ||
//                       widget.status == 'FINAL FACULTY ACCEPTED')
//                       ? true
//                       : false,
//                   userType: widget.userType,
//                   docID: widget.docID,
//                   reason: widget.reason,
//                   rejectedUser: widget.rejectedUser,
//                 )
//               ]),
//         ),
//       ),
//     );
//   }
// }
//
// class Event_Detail_Column extends StatefulWidget {
//   Event_Detail_Column(
//       {required this.id,
//         required this.date,
//         required this.student,
//         required this.event_start_time,
//         required this.event_end_time,
//         required this.venue,
//         required this.description,
//         required this.faculties_involved,
//         required this.isCompleted,
//         required this.status,
//         required this.userType,
//         required this.docID,
//         required this.reason,
//         required this.rejectedUser});
//
//   final String id,
//       date,
//       student,
//       event_start_time,
//       event_end_time,
//       venue,
//       description,
//       status,
//       userType,
//       docID,
//       reason,
//       rejectedUser;
//
//   final List<dynamic> faculties_involved;
//   final bool isCompleted;
//
//   @override
//   State<Event_Detail_Column> createState() => _Event_Detail_ColumnState();
// }
//
// String newReason = '';
//
// class _Event_Detail_ColumnState extends State<Event_Detail_Column> {
//   Widget _RejectButton(BuildContext context) {
//     if (widget.status != 'COMPLETED') {
//       return TextButton(
//         onPressed: () async {
//           showModalBottomSheet(
//             isScrollControlled: true,
//             context: context,
//             builder: (context) => SingleChildScrollView(
//                 child: Container(
//                   padding: EdgeInsets.only(
//                       bottom: MediaQuery.of(context).viewInsets.bottom + 30),
//                   child: Container(
//                     color: Color(0xFF757575),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(30),
//                               topLeft: Radius.circular(30))),
//                       padding: EdgeInsets.fromLTRB(40, 30, 40, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Reason',
//                             style: TextStyle(
//                                 color: Color(0xffe46b10),
//                                 fontSize: 35,
//                                 fontWeight: FontWeight.w700),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           TextFormField(
//                             autofocus: true,
//                             style: TextStyle(fontSize: 15),
//                             maxLines: 250,
//                             minLines: 1,
//                             onChanged: (value) {
//                               newReason = value;
//                             },
//                             decoration: InputDecoration(
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide:
//                                 BorderSide(color: Colors.grey, width: 0.5),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 borderSide:
//                                 BorderSide(color: Colors.grey, width: 0.5),
//                               ),
//                               focusColor: Colors.grey,
//                               contentPadding: EdgeInsets.all(12),
//                               hintStyle: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w300,
//                               ),
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: const BorderSide(width: 0.5)),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(7),
//                               color: Colors.black,
//                             ),
//                             child: TextButton(
//                                 onPressed: () async {
//                                   String adminMail = ' ';
//                                   final admins = await _firestore
//                                       .collection("Administrator User Details")
//                                       .get();
//                                   for (var admin in admins.docs) {
//                                     adminMail = admin.data()['Email'];
//                                   }
//                                   final data = {
//                                     "Status": 'REJECTED',
//                                     "Reason For Removal": newReason,
//                                     "Rejected User": adminMail
//                                   };
//                                   _firestore
//                                       .collection("Event Request")
//                                       .doc(widget.docID)
//                                       .set(data, SetOptions(merge: true));
//                                   Navigator.pop(context);
//                                   Navigator.pop(context);
//                                 },
//                                 child: Text(
//                                   'CONFIRM',
//                                   style: TextStyle(color: Colors.white),
//                                 )),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 )),
//           );
//         },
//         child: Container(
//           width: double.infinity,
//           padding: EdgeInsets.symmetric(vertical: 15),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(5)),
//               boxShadow: <BoxShadow>[
//                 BoxShadow(
//                     color: Colors.grey.shade200,
//                     offset: Offset(2, 4),
//                     blurRadius: 5,
//                     spreadRadius: 2)
//               ],
//               gradient: LinearGradient(
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                   colors: [Color(0xfffbb448), Color(0xfff7892b)])),
//           child: Text(
//             'REJECT',
//             style: TextStyle(fontSize: 20, color: Colors.white),
//           ),
//         ),
//       );
//     } else {
//       return Text('');
//     }
//   }
//
//   Widget _AdminAcceptButton(BuildContext context) {
//     if (widget.status != 'COMPLETED') {
//       return TextButton(
//         onPressed: () async {
//           final data = {"Status": 'ADMIN ACCEPTED'};
//           _firestore
//               .collection("Event Request")
//               .doc(widget.docID)
//               .set(data, SetOptions(merge: true));
//
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return Expanded(
//                 child: AlertDialog(
//                   title: Text('The Event Request has been Accepted'),
//                   // content: Text('GeeksforGeeks'),
//                   actions: [
//                     TextButton(
//                       onPressed: () {
//                         setState(() {});
//                         Navigator.pop(context);
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         padding: EdgeInsets.all(10),
//                         child: Text(
//                           'OK',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//         child: Container(
//           width: double.infinity,
//           padding: EdgeInsets.symmetric(vertical: 15),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(5)),
//               boxShadow: <BoxShadow>[
//                 BoxShadow(
//                     color: Colors.grey.shade200,
//                     offset: Offset(2, 4),
//                     blurRadius: 5,
//                     spreadRadius: 2)
//               ],
//               gradient: LinearGradient(
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                   colors: [Color(0xfffbb448), Color(0xfff7892b)])),
//           child: Text(
//             'ACCEPT',
//             style: TextStyle(fontSize: 20, color: Colors.white),
//           ),
//         ),
//       );
//     } else {
//       return Text('');
//     }
//   }
//
//   Widget bottompart(BuildContext context) {
//     String currentOrFinal = ' ';
//     Widget rejectButtton;
//     Widget adminAcceptButton;
//     if (widget.status == 'ONGOING') {
//       currentOrFinal = 'Current Faculty :';
//       rejectButtton = _RejectButton(context);
//       adminAcceptButton = Text('');
//     } else if (widget.status == 'FINAL FACULTY ACCEPTED') {
//       currentOrFinal = 'Final Faculty :';
//       rejectButtton = _RejectButton(context);
//       adminAcceptButton = _AdminAcceptButton(context);
//     } else if (widget.status == 'ADMIN ACCEPTED') {
//       currentOrFinal = 'Final Faculty :';
//       rejectButtton = _RejectButton(context);
//       adminAcceptButton = Text('');
//     } else {
//       rejectButtton = Text('');
//       adminAcceptButton = Text('');
//     }
//     return Column(
//       children: [
//         Text(
//           currentOrFinal,
//           textAlign: TextAlign.center,
//           style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Faculty_profile(
//                     facultyMail: widget.faculties_involved.last.toString(),
//                   ),
//                 ));
//           },
//           child: Text(
//             widget.faculties_involved.last,
//             style: TextStyle(
//                 fontWeight: FontWeight.w800,
//                 fontSize: 20,
//                 color: Colors.blueAccent),
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         rejectButtton,
//         SizedBox(
//           height: 30,
//         ),
//         adminAcceptButton
//       ],
//     );
//   }
//
//   List<Widget> facultylist(BuildContext context) {
//     List<Widget> FacultiesInvolvedList = [];
//
//     for (dynamic faculty in widget.faculties_involved) {
//       if (widget.faculties_involved.last.toString() != faculty.toString()) {
//         FacultiesInvolvedList.add(TextButton(
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Faculty_profile(
//                     facultyMail: faculty.toString(),
//                   ),
//                 ));
//           },
//           child: Text(
//             faculty.toString(),
//             style: TextStyle(
//                 fontWeight: FontWeight.w800,
//                 fontSize: 20,
//                 color: Colors.blueAccent),
//           ),
//         ));
//       }
//     }
//     return FacultiesInvolvedList;
//   }
//
//   Widget reasonText() {
//     if (widget.status == 'WITHDRAWN') {
//       return Text(
//         'REASON : ' + widget.reason,
//         textAlign: TextAlign.center,
//         style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
//       );
//     } else if (widget.status == 'REJECTED') {
//       return Column(
//         children: [
//           Text(
//             'REJECTED BY : ' + widget.rejectedUser,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             'REASON : ' + widget.reason,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
//           ),
//         ],
//       );
//     } else {
//       return Text('');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: Color(0xFFFAFAFA),
//         border: Border.all(
//           color: Colors.grey,
//           width: 0.4,
//         ),
//         boxShadow: [
//           BoxShadow(
//               color: Color(0x13000000),
//               blurRadius: 5,
//               spreadRadius: 1,
//               offset: Offset(0, 0)),
//         ],
//       ),
//       margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
//       child: Column(
//         children: [
//           SizedBox(
//             height: 20,
//           ),
//           Text(
//             'ID : ' + widget.id,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             'DATE : ' + widget.date,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             'GENERATED USER : ',
//             textAlign: TextAlign.center,
//             style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
//           ),
//           TextButton(
//             onPressed: () {
//               print(widget.userType);
//               if (widget.userType == 'FACULTY') {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => Faculty_profile(
//                         facultyMail: widget.student,
//                       ),
//                     ));
//               } else if (widget.userType == 'STUDENT') {
//                 print('student');
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => Student_Profile(
//                         studentMail: widget.student,
//                       ),
//                     ));
//               } else {
//                 print('admin');
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             Administrator_profile(adminMail: widget.student)));
//               }
//             },
//             child: Text(
//               widget.student,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontWeight: FontWeight.w800,
//                   fontSize: 20,
//                   color: Colors.blue),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             'EVENT START TIME : ' + widget.event_start_time,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             'EVENT END TIME : ' + widget.event_end_time,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             'VENUE : ' + widget.venue,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           Text(
//             'DESCRIPTION : ' + widget.description,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           Text(
//             'STATUS : ' + widget.status,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           reasonText(),
//           SizedBox(
//             height: 30,
//           ),
//           Text(
//             'FACULTIES INVOLVED:',
//             textAlign: TextAlign.center,
//             style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Column(
//             children: facultylist(
//                 context), //returns text widgets of all the faculties involved except the last
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           bottompart(
//               context) //returns the last faculty current faculty/final accept giving faculty
//         ],
//       ),
//     );
//   }
// }

// Container(
// width: double.infinity,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(15),
// color: Color(0xFFFAFAFA),
// border: Border.all(
// color: Colors.grey,
// width: 0.4,
// ),
// boxShadow: [
// BoxShadow(
// color: Color(0x13000000),
// blurRadius: 5,
// spreadRadius: 1,
// offset: Offset(0, 0)),
// ],
// ),
// margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
// child: Column(
// children: [
// SizedBox(
// height: 20,
// ),
// Text(
// 'ID : ' + widget.id,
// textAlign: TextAlign.center,
// style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
// ),
// SizedBox(
// height: 10,
// ),
// Text(
// 'DATE : ' + widget.date,
// textAlign: TextAlign.center,
// style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
// ),
// SizedBox(
// height: 10,
// ),
// Text(
// 'GENERATED USER : ',
// textAlign: TextAlign.center,
// style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
// ),
// TextButton(
// onPressed: () {
// print(widget.userType);
// if (widget.userType == 'FACULTY') {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => Faculty_profile(
// facultyMail: widget.student,
// ),
// ));
// } else if (widget.userType == 'STUDENT') {
// print('student');
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => Student_Profile(
// studentMail: widget.student,
// ),
// ));
// } else {
// print('admin');
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) =>
// Administrator_profile(adminMail: widget.student)));
// }
// },
// child: Text(
// widget.student,
// textAlign: TextAlign.center,
// style: TextStyle(
// fontWeight: FontWeight.w800,
// fontSize: 20,
// color: Colors.blue),
// ),
// ),
// SizedBox(
// height: 10,
// ),
// Text(
// 'EVENT START TIME : ' + widget.event_start_time,
// textAlign: TextAlign.center,
// style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
// ),
// SizedBox(
// height: 10,
// ),
// Text(
// 'EVENT END TIME : ' + widget.event_end_time,
// textAlign: TextAlign.center,
// style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
// ),
// SizedBox(
// height: 10,
// ),
// Text(
// 'VENUE : ' + widget.venue,
// textAlign: TextAlign.center,
// style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
// ),
// SizedBox(
// height: 30,
// ),
// Text(
// 'DESCRIPTION : ' + widget.description,
// textAlign: TextAlign.center,
// style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
// ),
// SizedBox(
// height: 30,
// ),
// Text(
// 'STATUS : ' + widget.status,
// textAlign: TextAlign.center,
// style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
// ),
// SizedBox(
// height: 30,
// ),
// reasonText(),
// SizedBox(
// height: 30,
// ),
// Text(
// 'FACULTIES INVOLVED:',
// textAlign: TextAlign.center,
// style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
// ),
// SizedBox(
// height: 10,
// ),
// Column(
// children: facultylist(
// context), //returns text widgets of all the faculties involved except the last
// ),
// SizedBox(
// height: 20,
// ),
// bottompart(
// context) //returns the last faculty current faculty/final accept giving faculty
// ],
// ),
// );
