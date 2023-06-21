import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_consent2/admininstrator_profile.dart';
import 'package:event_consent2/allFacultys.dart';
import 'package:event_consent2/allStudents.dart';
import 'package:event_consent2/calendar.dart';
import 'package:event_consent2/departments.dart';
import 'package:event_consent2/venues.dart';
import 'package:flutter/material.dart';
import 'package:event_consent2/clubs.dart';

class Add_Info extends StatefulWidget {
  Add_Info({required this.userType});
  String userType;

  @override
  State<Add_Info> createState() => _Add_InfoState();
}

final _firestore = FirebaseFirestore.instance;

class _Add_InfoState extends State<Add_Info> {
  Widget _title() {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        text: 'Information',
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: Color(0xffe46b10),
        ),
      ),
    );
  }

  String adminMail = ' ';
  void adminMailFinder() async {
    final admins =
        await _firestore.collection("Administrator User Details").get();
    for (var admin in admins.docs) {
      setState(() {
        adminMail = admin.data()['Email'];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adminMailFinder();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(20, 46, 0, 30),
                child: _title(),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView(
                  children: [
                    InfoCard(
                      infoType: 'Calendar',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Calendar(
                              userType: widget.userType,
                            ),
                          ),
                        );
                      },
                    ),
                    InfoCard(
                      infoType: 'Venues',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Venues(
                              userType: widget.userType,
                            ),
                          ),
                        );
                      },
                    ),
                    InfoCard(
                      infoType: 'Departments',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Department(
                              userType: widget.userType,
                            ),
                          ),
                        );
                      },
                    ),
                    InfoCard(
                      infoType: 'Clubs',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Clubs(
                              userType: widget.userType,
                            ),
                          ),
                        );
                      },
                    ),
                    InfoCard(
                      infoType: 'Students',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => allStudents(),
                          ),
                        );
                      },
                    ),
                    InfoCard(
                      infoType: 'Faculties',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => allFcaultys(),
                          ),
                        );
                      },
                    ),
                    InfoCard(
                      infoType: 'Administrator',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Administrator_profile(adminMail: adminMail),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  InfoCard({required this.infoType, required this.onPressed});
  final String infoType;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: TextButton(
        onPressed: onPressed,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xFFFAFAFA),
            border: Border.all(
              color: Colors.grey,
              width: 0.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x0f000000),
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 25, 10, 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    infoType,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Icon(
                  Icons.navigate_next,
                  size: 60,
                  color: Colors.black54,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
