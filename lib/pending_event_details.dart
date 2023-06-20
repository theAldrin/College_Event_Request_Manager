import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_consent2/student_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'admininstrator_profile.dart';
import 'faculty_profile.dart';

class Pending_Event_Details extends StatefulWidget {
  Pending_Event_Details({required this.eventDocumentID});
  String eventDocumentID;
  @override
  State<Pending_Event_Details> createState() => _Pending_Event_DetailsState();
}

final _firestore = FirebaseFirestore.instance;
dynamic loggedInUser;
int clashFlag = 0;

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
      status = '',
      userType = '';
  late List<dynamic> facultiesInvolved = [], requiredFaculties = [];

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
      userType = event.data()?['User Type'];
      requiredFaculties = event.data()?['Required Faculties'];
    });
  }

  var faculties;
  void getallFaculties() async {
    final facultyData =
        await _firestore.collection('Faculty User Details').get();
    faculties = facultyData.docs;
    for (var faculty in faculties) {
      if ((faculty.data()['Email'] != loggedInUser.email)) {
        setState(() {
          facultyMails.add(faculty.data()['Email']);
        });
      }
    }
  }

  String facultyNameFromMailString(String facultyMail) {
    for (var faculty1 in faculties) {
      if (faculty1.data()['Email'] == facultyMail) {
        return faculty1.data()['Name'].toString();
      }
    }
    return '';
  }

  bool checkRequiredFaculties() {
    bool flag = true;
    List<String> stringFacultiesInvolved =
        facultiesInvolved.map((dynamic item) => item.toString()).toList();
    for (String fac in requiredFaculties) {
      if (!stringFacultiesInvolved.contains(fac)) {
        setState(() {
          facultiesNotInFacultiesInvolved +=
              ('${facultyNameFromMailString(fac)}  ($fac)\n');
        });
        flag = false;
      }
    }
    return flag;
  }

  String facultiesNotInFacultiesInvolved = '';

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
  int flagVerify = 0;

  Widget bottomPart() {
    if (flagVerify == 0) {
      return SizedBox(
        width: double.infinity,
        child: Card(
          color: Color(0xfff7892b),
          child: InkWell(
            onTap: () async {
              // Action to perform when the button is pressed
              clashFlag = 0;
              final eventCollection =
                  await _firestore.collection('Event Request').get();
              for (var event in eventCollection.docs) {
                // DateTime tempDate = new DateFormat("dd-MM-yyyy")
                //     .parse(event.data()['Date']);
                // String datesh = DateFormat("yyyy-MM-dd hh:mm:ss")
                //     .format(tempDate);
                // print(datesh);
                if ((event.data()['Date'] == date) &&
                    (event.data()['Venue'] == venue) &&
                    (event.data()['ID'].toString() != id)) {
                  //TODO: Admin accepted status check
                  DateTime thisEventStartTime =
                      new DateFormat("hh:mm").parse(eventStartTime);

                  DateTime thisEventEndTime =
                      new DateFormat("hh:mm").parse(eventEndTime);
                  // String datesh = DateFormat("yyyy-MM-dd hh:mm:ss")
                  //     .format(thisEventEndTime);
                  // print(datesh);
                  DateTime databaseEventStartTime = new DateFormat("hh:mm")
                      .parse(event.data()['Event Start Time']);
                  DateTime databaseEventEndTime = new DateFormat("hh:mm")
                      .parse(event.data()['Event End Time']);
                  if ((thisEventStartTime
                          .isAtSameMomentAs(databaseEventStartTime)) ||
                      (thisEventStartTime
                          .isAtSameMomentAs(databaseEventEndTime)) ||
                      ((thisEventStartTime.isAfter(databaseEventStartTime)) &&
                          (thisEventStartTime
                              .isBefore(databaseEventEndTime))) ||
                      (thisEventEndTime
                          .isAtSameMomentAs(databaseEventStartTime)) ||
                      (thisEventEndTime
                          .isAtSameMomentAs(databaseEventEndTime)) ||
                      ((thisEventEndTime.isAfter(databaseEventStartTime)) &&
                          (thisEventEndTime.isBefore(databaseEventEndTime))) ||
                      ((thisEventStartTime.isBefore(databaseEventStartTime)) &&
                          (thisEventEndTime.isAfter(databaseEventEndTime)))) {
                    clashFlag = 1;
                  }
                }
              }
              if (clashFlag == 1) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('ATTENTION!!!'),
                      content: Text(
                          'The event clashes with other preplanned Event. Please Reject it'),
                      // content: Text('GeeksforGeeks'),
                      actions: [
                        TextButton(
                          onPressed: () async {
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
                    );
                  },
                );
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Date, Time and Venue Verified'),
                      content:
                          Text('Please forward the Event or give Final accept'),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              flagVerify = 1;
                            });
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
                    );
                  },
                );
              }
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
      );
    } else {
      return Column(
        children: [
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
            items: facultyMails.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                  if (_selectedOption != null) {
                    // Action to perform when the button is pressed
                    facultiesInvolved.add(_selectedOption);
                    final data = {"FacultIies Involved": facultiesInvolved};
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
                  }
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
                  if (checkRequiredFaculties()) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
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
                                    return AlertDialog(
                                      title: Text(
                                          'Do you want to give final accept to this event Request'),
                                      //content: Text('Are you sure you have the authority to give final accept this event request'),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            final data = {
                                              "Status":
                                                  'FINAL FACULTY ACCEPTED',
                                            };
                                            _firestore
                                                .collection("Event Request")
                                                .doc(widget.eventDocumentID)
                                                .set(data,
                                                    SetOptions(merge: true));
                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'Final accept for the event is provided'),
                                                  //content: Text('Are you sure you have the authority to give final accept this event request'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: Text(
                                                          'OK',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              'YES',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
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
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                              'You cannot give final accept for this event Please forward this to any of the faculties mentioned below'),
                          content: Text(facultiesNotInFacultiesInvolved),
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
                        );
                      },
                    );
                  }
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
        ],
      );
    }
  }

  String newReason = '';

  @override
  Widget build(BuildContext context) {
    facultyMails.remove(student);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                    userType: userType,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  bottomPart(),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: Color(0xfff7892b),
                      child: InkWell(
                        onTap: () async {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => SingleChildScrollView(
                                child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom +
                                          30),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 0.5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 0.5),
                                          ),
                                          focusColor: Colors.grey,
                                          contentPadding: EdgeInsets.all(12),
                                          hintStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide:
                                                  const BorderSide(width: 0.5)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.black,
                                        ),
                                        child: TextButton(
                                            onPressed: () {
                                              final data = {
                                                "Status": 'REJECTED',
                                                "Reason For Removal": newReason,
                                                "Rejected User":
                                                    loggedInUser.email
                                              };
                                              _firestore
                                                  .collection("Event Request")
                                                  .doc(widget.eventDocumentID)
                                                  .set(data,
                                                      SetOptions(merge: true));
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'CONFIRM',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'REJECT',
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
      required this.isCompleted,
      required this.userType});

  final String id,
      date,
      student,
      event_start_time,
      event_end_time,
      venue,
      description,
      userType;

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
            'GENERATED USER : ',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
          ),
          TextButton(
            onPressed: () {
              if (userType == 'FACULTY') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Faculty_profile(
                        facultyMail: student,
                      ),
                    ));
              } else if (userType == 'STUDENT') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Student_Profile(
                        studentMail: student,
                      ),
                    ));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Administrator_profile(adminMail: student)));
              }
            },
            child: Text(
              student,
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
      ),
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
