import 'package:flutter/material.dart';
import 'student_faculty_event_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Event_history extends StatefulWidget {
  Event_history({required this.userType});
  String userType;
  @override
  State<Event_history> createState() => _Event_historyState();
}

final _firestore = FirebaseFirestore.instance;
dynamic loggedInUser;

class _Event_historyState extends State<Event_history> {
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
        text: 'Event History',
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10)),
      ),
    );
  }

  double scrolloffset = 0;
  void setVisibility(double scrollOffset) {
    setState(() {
      scrolloffset = scrollOffset;
    });
  }

  String? _selectedStatus = 'ALL', _selectedUserType = 'ALL';
  late String _searchText = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xffffff),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(20, 46, 0, 30),
                child: _title(),
                width: double.infinity,
              ),
              Visibility(
                visible: scrolloffset > 20 ? false : true,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 23),
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
                    SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Row(
                        mainAxisAlignment: widget.userType == 'FACULTY'
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(6, 0, 0, 3.5),
                                child: Text(
                                  'STATUS',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.9,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 0),
                                  child: DropdownButton<String>(
                                    //isExpanded: true,
                                    iconEnabledColor: Color(0xfff7892b),
                                    iconSize: 25,
                                    underline: SizedBox(),
                                    value: _selectedStatus,
                                    items: <String>[
                                      'ALL',
                                      'ONGOING',
                                      'FINAL FACULTY ACCEPTED',
                                      'ADMIN ACCEPTED',
                                      'COMPLETED',
                                      'REJECTED',
                                      'WITHDRAWN'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      // Change function parameter to nullable string
                                      setState(() {
                                        _selectedStatus = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          widget.userType == 'FACULTY'
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          6, 0, 0, 3.5),
                                      child: Text(
                                        'USER',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 0.9,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 1),
                                        child: DropdownButton<String>(
                                          //isExpanded: true,
                                          iconEnabledColor: Color(0xfff7892b),
                                          iconSize: 25,
                                          underline: SizedBox(),
                                          value: _selectedUserType,
                                          items: <String>[
                                            'ALL',
                                            'MY EVENTS',
                                            'OTHERS EVENTS',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            // Change function parameter to nullable string
                                            setState(() {
                                              _selectedUserType = newValue;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Text(''),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              MessageStream(
                userType: widget.userType,
                searchText: _searchText,
                selectedStatus: _selectedStatus.toString(),
                selectedUserType: _selectedUserType.toString(),
                students: students,
                faculties: faculties,
                admins: admins,
                visibilitysetter: setVisibility,
              ),
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

class MessageStream extends StatefulWidget {
  MessageStream(
      {required this.userType,
      required this.searchText,
      required this.selectedStatus,
      required this.selectedUserType,
      required this.students,
      required this.faculties,
      required this.admins,
      required this.visibilitysetter});
  String userType;
  final String searchText, selectedUserType, selectedStatus;
  var students, faculties, admins;
  Function visibilitysetter;

  @override
  State<MessageStream> createState() => _MessageStreamState();
}

class _MessageStreamState extends State<MessageStream> {
  ScrollController _scrollController = ScrollController();
  double scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      scrollOffset = _scrollController.offset;
      print('Scroll Offset: $scrollOffset');
      widget.visibilitysetter(scrollOffset);
    });
  }

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
            if (event
                    .data()['Event Name']
                    .toLowerCase()
                    .contains(widget.searchText.toLowerCase()) ||
                event
                    .data()['ID']
                    .toString()
                    .toLowerCase()
                    .contains(widget.searchText.toLowerCase()) ||
                event
                    .data()['Date']
                    .toLowerCase()
                    .contains(widget.searchText.toLowerCase()) ||
                event
                    .data()['Generated User']
                    .toLowerCase()
                    .contains(widget.searchText.toLowerCase())) {
              if ((widget.selectedStatus == 'ALL') ||
                  (widget.selectedStatus == event.data()['Status'])) {
                if ((widget.selectedUserType == 'ALL') ||
                    ((widget.selectedUserType == 'MY EVENTS') &&
                        (event.data()['Generated User'] ==
                            loggedInUser.email)) ||
                    ((widget.selectedUserType == 'OTHERS EVENTS') &&
                        (event.data()['Generated User'] !=
                            loggedInUser.email))) {
                  bool flag = false;
                  for (String facultyMails
                      in event.data()['FacultIies Involved']) {
                    if ((loggedInUser.email == facultyMails) &&
                        (event.data()['FacultIies Involved'].last !=
                            facultyMails)) {
                      flag = true;
                    }
                    if ((event.data()['Status'] != 'ONGOING') &&
                        (event.data()['FacultIies Involved'].last ==
                            facultyMails) &&
                        (loggedInUser.email == facultyMails)) {
                      flag = true;
                    }
                  }
                  if (loggedInUser.email == event.data()['Generated User'] ||
                      flag) {
                    final eventCard = EventCard(
                        eventTitle: event.data()['Event Name'],
                        eventId: event.data()['ID'].toString(),
                        date: event.data()['Date'],
                        student: generatedUserName(
                            event.data()['User Type'],
                            event.data()['Generated User'],
                            widget.admins,
                            widget.faculties,
                            widget.students),
                        eventstatus: event.data()['Status'],
                        nextpage: Student_Faculty_event_details(
                          docId: event.id,
                        ),
                        context: context);
                    EventRequests.add(eventCard);
                  }
                }
              }
            }
          }
          return Expanded(
            child: ListView(
              controller: _scrollController,
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
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => nextpage,
        ));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 1),
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
