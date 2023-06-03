import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Event_request extends StatefulWidget {
  Event_request({required this.userType});
  String userType;

  @override
  State<Event_request> createState() => _Event_requestState();
}

class _Event_requestState extends State<Event_request> {
  final _auth = FirebaseAuth.instance;
  dynamic loggedInUser;
  final _firestore = FirebaseFirestore.instance;

  late DateTime date;
  String formattedDate = '',
      eventName = '',
      formattedStartTime = '',
      formattedEndTime = '',
      description = '';
  List<String> venuesList = ['OUTSIDE CAMPUS'];
  List<String> facultyList = ['ADMINISTRATOR'];
  String? venue = 'OUTSIDE CAMPUS', faculty = 'ADMINISTRATOR';

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

  void getAllVenues() async {
    await for (var snapshot in _firestore.collection('Venues').snapshots()) {
      for (var venue1 in snapshot.docs) {
        venuesList.add(venue1.data()['Name']);
      }
    }
  }

  void getallFaculties() async {
    final facultyData =
        await _firestore.collection('Faculty User Details').get();
    final faculties = facultyData.docs;
    for (var faculty1 in faculties) {
      if ((faculty1.data()['Email'] != loggedInUser.email)) {
        facultyList.add(faculty1.data()['Email']);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getAllVenues();
    getallFaculties();
    // print(facultyList);
    // print(venuesList);
    // venue = venuesList.first;
    // faculty = facultyList.first;
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Event Request',
          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)),
        ),
      ),
    );
  }

  late int clashFlag;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 90),
              _title(),
              SizedBox(height: 50),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Event Name',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        onChanged: (value) {
                          eventName = value;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color(0xfff3f3f4),
                            filled: true))
                  ],
                ),
              ), //Event Name
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  DatePickerBdaya.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2025, 12, 31), onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    print('confirm $date');
                    setState(() {
                      formattedDate = DateFormat('dd-MM-yyyy').format(date);
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Container(
                  //margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Date',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        width: double.infinity,
                        height: 50,
                        color: Color(0x2FCECECE),
                        child: Text(
                          formattedDate,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ), //Date setter
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  DatePickerBdaya.showTimePicker(context,
                      showTitleActions: true, onChanged: (date) {
                    debugPrint(
                        'change $date in time zone ${date.timeZoneOffset.inHours}');
                  }, onConfirm: (date) {
                    debugPrint('confirm $date');
                    setState(() {
                      formattedStartTime = DateFormat.Hm().format(date);
                    });
                  }, currentTime: DateTime.now());
                },
                child: Container(
                  //margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Event Start Time',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        width: double.infinity,
                        height: 50,
                        color: Color(0x2FCECECE),
                        child: Text(
                          formattedStartTime,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ), //Start time Picker
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  DatePickerBdaya.showTimePicker(context,
                      showTitleActions: true, onChanged: (date) {
                    debugPrint(
                        'change $date in time zone ${date.timeZoneOffset.inHours}');
                  }, onConfirm: (date) {
                    debugPrint('confirm $date');
                    setState(() {
                      formattedEndTime = DateFormat.Hm().format(date);
                    });
                  }, currentTime: DateTime.now());
                },
                child: Container(
                  //margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Event End Time',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        width: double.infinity,
                        height: 50,
                        color: Color(0x2FCECECE),
                        child: Text(
                          formattedEndTime,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ), //End time Picker
              SizedBox(height: 10),
              Text(
                'Venue',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              DropdownButton<String>(
                isExpanded: true,
                iconEnabledColor: Color(0xfff7892b),
                iconSize: 60,
                value: venue,
                items: venuesList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Change function parameter to nullable string
                  setState(() {
                    venue = newValue;
                  });
                },
              ), //hallRoom
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Event Description',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 15),
                      maxLines: 250,
                      minLines: 1,
                      onChanged: (value) {
                        description = value;
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
                  ],
                ),
              ), //Event Description
              SizedBox(height: 10),
              Text(
                'Associated Faculty Email',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              DropdownButton<String>(
                isExpanded: true,
                iconEnabledColor: Color(0xfff7892b),
                iconSize: 60,
                value: faculty,
                items:
                    facultyList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Change function parameter to nullable string
                  setState(() {
                    faculty = newValue;
                  });
                },
              ), //faculty Mail
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        clashFlag = 0;
                        final eventCollection =
                            await _firestore.collection('Event Request').get();
                        for (var event in eventCollection.docs) {
                          // DateTime tempDate = new DateFormat("dd-MM-yyyy")
                          //     .parse(event.data()['Date']);
                          // String datesh = DateFormat("yyyy-MM-dd hh:mm:ss")
                          //     .format(tempDate);
                          // print(datesh);
                          if ((event.data()['Date'] == formattedDate) &&
                              (event.data()['Venue'] == venue)) {
                            //TODO: Admin accepted status check
                            DateTime thisEventStartTime =
                                new DateFormat("hh:mm")
                                    .parse(formattedStartTime);

                            DateTime thisEventEndTime =
                                new DateFormat("hh:mm").parse(formattedEndTime);
                            // String datesh = DateFormat("yyyy-MM-dd hh:mm:ss")
                            //     .format(thisEventEndTime);
                            // print(datesh);
                            DateTime databaseEventStartTime =
                                new DateFormat("hh:mm")
                                    .parse(event.data()['Event Start Time']);
                            DateTime databaseEventEndTime =
                                new DateFormat("hh:mm")
                                    .parse(event.data()['Event End Time']);
                            if ((thisEventStartTime.isAtSameMomentAs(
                                    databaseEventStartTime)) ||
                                (thisEventStartTime
                                    .isAtSameMomentAs(databaseEventEndTime)) ||
                                ((thisEventStartTime
                                        .isAfter(databaseEventStartTime)) &&
                                    (thisEventStartTime
                                        .isBefore(databaseEventEndTime))) ||
                                (thisEventEndTime.isAtSameMomentAs(
                                    databaseEventStartTime)) ||
                                (thisEventEndTime
                                    .isAtSameMomentAs(databaseEventEndTime)) ||
                                ((thisEventEndTime
                                        .isAfter(databaseEventStartTime)) &&
                                    (thisEventEndTime
                                        .isBefore(databaseEventEndTime))) ||
                                ((thisEventStartTime
                                        .isBefore(databaseEventStartTime)) &&
                                    (thisEventEndTime
                                        .isAfter(databaseEventEndTime)))) {
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
                                    'Your Event Clashes with another Event. Please change the time and try again'),
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
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Date, Time and Venue Verified'),
                                content: Text('Please Submit the Event'),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      final constantDB = await _firestore
                                          .collection('Constants')
                                          .get();
                                      final constant = constantDB.docs[0];
                                      int id = constant.data()['Event ID'];
                                      ++id;
                                      await _firestore
                                          .collection('Constants')
                                          .doc('gaLPmBXkrPt1m6I31CjJ')
                                          .update({'Event ID': id});
                                      await _firestore
                                          .collection('Event Request')
                                          .add({
                                        'ID': id,
                                        'Event Name': eventName,
                                        'Date': formattedDate,
                                        'Event Start Time': formattedStartTime,
                                        'Event End Time': formattedEndTime,
                                        'Venue': venue,
                                        'Event Description': description,
                                        'FacultIies Involved': [faculty],
                                        'Generated User': loggedInUser.email,
                                        'Status': 'ONGOING',
                                        'TimeStamp':
                                            FieldValue.serverTimestamp(),
                                        'User Type': widget.userType
                                      });
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Expanded(
                                            child: AlertDialog(
                                              title: Text(
                                                  'Event Request has been submitted succesfully'),
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
                                                      style: TextStyle(
                                                          color: Colors.white),
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
                                        'SUBMIT',
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
                                colors: [
                                  Color(0xfffbb448),
                                  Color(0xfff7892b)
                                ])),
                        child: Center(
                          child: Text(
                            'VERIFY',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ), //verify button functionality
                  // SizedBox(
                  //   width: 20,
                  // ),
                  // Expanded(
                  //   child: TextButton(
                  //     onPressed: () async {
                  //       final constantDB =
                  //           await _firestore.collection('Constants').get();
                  //       final constant = constantDB.docs[0];
                  //       int id = constant.data()['Event ID'];
                  //       ++id;
                  //       await _firestore
                  //           .collection('Constants')
                  //           .doc('gaLPmBXkrPt1m6I31CjJ')
                  //           .update({'Event ID': id});
                  //       await _firestore.collection('Event Request').add({
                  //         'ID': id,
                  //         'Event Name': eventName,
                  //         'Date': formattedDate,
                  //         'Event Start Time': formattedStartTime,
                  //         'Event End Time': formattedEndTime,
                  //         'Venue': venue,
                  //         'Event Description': description,
                  //         'FacultIies Involved': [faculty],
                  //         'Generated User': loggedInUser.email,
                  //         'Status': 'ONGOING',
                  //         'TimeStamp': FieldValue.serverTimestamp()
                  //       });
                  //       showDialog(
                  //         context: context,
                  //         builder: (BuildContext context) {
                  //           return Expanded(
                  //             child: AlertDialog(
                  //               title: Text(
                  //                   'Event Request has been submitted succesfully'),
                  //               // content: Text('GeeksforGeeks'),
                  //               actions: [
                  //                 TextButton(
                  //                   onPressed: () {
                  //                     Navigator.pop(context);
                  //                   },
                  //                   child: Container(
                  //                     padding: EdgeInsets.all(10),
                  //                     child: Text(
                  //                       'OK',
                  //                       style: TextStyle(color: Colors.white),
                  //                     ),
                  //                     color: Colors.black,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           );
                  //         },
                  //       );
                  //     },
                  //     child: Container(
                  //       padding: EdgeInsets.symmetric(vertical: 15),
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.all(Radius.circular(5)),
                  //           boxShadow: <BoxShadow>[
                  //             BoxShadow(
                  //                 color: Colors.grey.shade200,
                  //                 offset: Offset(2, 4),
                  //                 blurRadius: 5,
                  //                 spreadRadius: 2)
                  //           ],
                  //           gradient: LinearGradient(
                  //               begin: Alignment.centerLeft,
                  //               end: Alignment.centerRight,
                  //               colors: [
                  //                 Color(0xfffbb448),
                  //                 Color(0xfff7892b)
                  //               ])),
                  //       child: Center(
                  //         child: Text(
                  //           'SUBMIT',
                  //           style: TextStyle(fontSize: 20, color: Colors.white),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ), //Submit button functionality
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    ));
  }
}
