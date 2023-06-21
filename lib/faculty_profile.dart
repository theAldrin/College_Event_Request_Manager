import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_consent2/student_profile_edit.dart';
import 'package:event_consent2/welcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'faculty_profile_edit.dart';

class Faculty_profile extends StatefulWidget {
  Faculty_profile({required this.facultyMail});
  final String facultyMail;

  @override
  State<Faculty_profile> createState() => _Faculty_profileState();
}

final _firestore = FirebaseFirestore.instance;

class _Faculty_profileState extends State<Faculty_profile> {
  final _auth = FirebaseAuth.instance;
  late String currentUserEmail = '';

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        setState(() {
          currentUserEmail = user.email!;
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
    getData();
  }

  void getData() async {
    await for (var snapshot
        in _firestore.collection('Faculty User Details').snapshots()) {
      for (var user in snapshot.docs) {
        if (widget.facultyMail == user.data()['Email']) {
          setState(() {
            name = user.data()['Name'];
            college = user.data()['College'];
            email = user.data()['Email'];
            department = user.data()['Department'];
            position = user.data()['Position'];
            clubs = user.data()['Clubs'];
            phoneno = user.data()['Phone No'];
            imageUrl = user.data()['Image'];
          });
        }
      }
    }
  }

  String name = '',
      college = '',
      email = '',
      department = '',
      position = '',
      clubs = '',
      phoneno = '',
      imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              currentUserEmail == widget.facultyMail
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () async {
                            await _auth.signOut();
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomePage()),
                            );
                          },
                          child: Icon(
                            Icons.exit_to_app,
                            color: Colors.black54,
                            size: 30,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Faculty_profile_edit(),
                                ));
                          },
                          child: Icon(
                            Icons.edit,
                            color: Colors.black54,
                            size: 30,
                          ),
                        )
                      ],
                    )
                  : Row(
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
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(imageUrl),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                name,
                style: TextStyle(
                  //fontFamily: 'Pacifico',
                  fontSize: 40.0,
                  color: Color(0xfff3892b),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                position,
                style: TextStyle(
                  //fontFamily: 'Source Sans Pro',
                  color: Color(0x90f3892b),
                  fontSize: 20.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.yellow.shade900,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              ProfileDetailsCard(
                icon: Icons.school,
                text: college,
              ),
              ProfileDetailsCard(
                icon: Icons.class_,
                text: department,
              ),
              ProfileDetailsCard(
                icon: Icons.party_mode,
                text: clubs,
              ),
              GestureDetector(
                onTap: () async {
                  await FlutterPhoneDirectCaller.callNumber(phoneno.toString());
                },
                child: ProfileDetailsCard(
                  icon: Icons.phone,
                  text: phoneno,
                ),
              ),
              GestureDetector(
                onTap: () {
                  final Uri emailUri = Uri(scheme: 'mailto', path: email);
                  launchUrl(emailUri);
                },
                child: ProfileDetailsCard(
                  icon: Icons.email,
                  text: email,
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class ProfileDetailsCard extends StatelessWidget {
  ProfileDetailsCard({required this.icon, required this.text});
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: Color(0xfff3892b),
          ),
          title: Text(
            text,
            style: TextStyle(
              color: Colors.black54,
              //fontFamily: 'Source Sans Pro',
              fontSize: 17.5,
            ),
          ),
        ));
  }
}
