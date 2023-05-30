import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'faculty_profile.dart';

class Pending_Event_Details extends StatefulWidget {
  Pending_Event_Details({required this.eventDocumentID});
  String eventDocumentID;
  @override
  State<Pending_Event_Details> createState() => _Pending_Event_DetailsState();
}

final _firestore = FirebaseFirestore.instance;
dynamic loggedInUser;

class _Pending_Event_DetailsState extends State<Pending_Event_Details> {
  late List<String> facultyMails = [];
  final _auth = FirebaseAuth.instance;

  late String id = '',
      date = '',
      student = '',
      eventStartTime = '',
      eventEndTime = '',
      venue = '',
      description = '',
      name = '',
      status = '';
  late List<dynamic> facultiesInvolved = [];

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

  void getData() async {
    var event = await _firestore
        .collection("Event Request")
        .doc(widget.eventDocumentID)
        .get();
    setState(() {
      name = event.data()?['Event Name'];
      id = event.data()!['ID'].toString();
      date = event.data()?['Date'];
      student = event.data()?['Generated User'];
      eventStartTime = event.data()?['Event Start Time'];
      eventEndTime = event.data()?['Event End Time'];
      venue = event.data()?['Venue'];
      description = event.data()?['Event Description'];
      facultiesInvolved = event.data()?['FacultIies Involved'];
      status = event.data()?['Status'];
    });
  }

  void getallFaculties() async {
    final facultyData =
        await _firestore.collection('Faculty User Details').get();
    final faculties = facultyData.docs;
    for (var faculty in faculties) {
      if ((faculty.data()['Email'] != loggedInUser.email)) {
        setState(() {
          facultyMails.add(faculty.data()['Email']);
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    getData();
    getallFaculties();
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: name,
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10)),
      ),
    );
  }

  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    facultyMails.remove(student);
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFF8F4F2),
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
                    id: id,
                    date: date,
                    student: student,
                    event_start_time: eventStartTime,
                    event_end_time: eventEndTime,
                    venue: venue,
                    description: description,
                    faculties_involved: facultiesInvolved,
                    isCompleted:
                        (status == 'ADMIN ACCEPTED' || status == 'COMPLETED')
                            ? true
                            : false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: Color(0xfff7892b),
                      child: InkWell(
                        onTap: () {
                          // Action to perform when the button is pressed
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Expanded(
                                child: AlertDialog(
                                  title: Text('Date Time and Venue verified'),
                                  // content: Text('GeeksforGeeks'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
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
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'VERIFY',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Forward To',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    iconEnabledColor: Color(0xfff7892b),
                    iconSize: 60,
                    value: _selectedOption,
                    items: facultyMails
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // Change function parameter to nullable string
                      setState(() {
                        _selectedOption = newValue;
                      });
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: Color(0xfff7892b),
                      child: InkWell(
                        onTap: () {
                          // Action to perform when the button is pressed
                          facultiesInvolved.add(_selectedOption);
                          final data = {
                            "FacultIies Involved": facultiesInvolved
                          };
                          _firestore
                              .collection("Event Request")
                              .doc(widget.eventDocumentID)
                              .set(data, SetOptions(merge: true));
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Expanded(
                                child: AlertDialog(
                                  title: Text('Event request forwarded'),
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
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'FORWARD',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'OR',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: Color(0xfff7892b),
                      child: InkWell(
                        onTap: () {
                          // Action to perform when the button is pressed
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Expanded(
                                child: AlertDialog(
                                  title: Text('ATTENTION !!!'),
                                  content: Text(
                                      'Are you sure you have the authority to give final accept this event request'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Expanded(
                                              child: AlertDialog(
                                                title: Text(
                                                    'Do you want to give final accept to this event Request'),
                                                //content: Text('Are you sure you have the authority to give final accept this event request'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      final data = {
                                                        "Status":
                                                            'FINAL FACULTY ACCEPTED'
                                                      };
                                                      _firestore
                                                          .collection(
                                                              "Event Request")
                                                          .doc(widget
                                                              .eventDocumentID)
                                                          .set(
                                                              data,
                                                              SetOptions(
                                                                  merge: true));
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Expanded(
                                                            child: AlertDialog(
                                                              title: Text(
                                                                  'Final accept for the event is provided'),
                                                              //content: Text('Are you sure you have the authority to give final accept this event request'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10),
                                                                    child: Text(
                                                                      'OK',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Text(
                                                        'YES',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          'YES',
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
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'FINAL ACCEPT',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class Event_Detail_Column extends StatelessWidget {
  Event_Detail_Column(
      {required this.id,
      required this.date,
      required this.student,
      required this.event_start_time,
      required this.event_end_time,
      required this.venue,
      required this.description,
      required this.faculties_involved,
      required this.isCompleted});

  final String id,
      date,
      student,
      event_start_time,
      event_end_time,
      venue,
      description;

  final List<dynamic> faculties_involved;
  final bool isCompleted;

  List<Widget> facultylist(BuildContext context) {
    List<Widget> FacultiesInvolvedList = [];

    for (dynamic faculty in faculties_involved) {
      if (faculties_involved.last.toString() != faculty.toString()) {
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
          'ID : ' + id,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'DATE : ' + date,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'STUDENT : ' + student,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'EVENT START TIME : ' + event_start_time,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'EVENT END TIME : ' + event_end_time,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'VENUE : ' + venue,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'DESCRIPTION : ' + description,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'FACULTIES ALREADY APPROVED:',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          children: facultylist(context),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class SubmitButton extends StatelessWidget {
  SubmitButton({required this.text, required this.nextpage});
  String text;
  Widget nextpage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => nextpage,
              ));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
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
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
