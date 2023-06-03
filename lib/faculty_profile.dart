import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
          });
        }
      }
    }
  }

  Widget _submitButton() {
    if (currentUserEmail == widget.facultyMail) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Faculty_profile_edit(),
              ));
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(120, 15, 120, 30),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              // boxShadow: <BoxShadow>[
              //   BoxShadow(
              //       color: Colors.grey.shade900,
              //       offset: Offset(2, 4),
              //       blurRadius: 5,
              //       spreadRadius: 2)
              // ],
              color: Color(0xFF000000)),
          child: Text(
            'EDIT',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
    } else {
      return Text('');
    }
  }

  String name = '',
      college = '',
      email = '',
      department = '',
      position = '',
      clubs = '',
      phoneno = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('images/ereh.png'),
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
              ProfileDetailsCard(
                icon: Icons.phone,
                text: phoneno,
              ),
              ProfileDetailsCard(
                icon: Icons.email,
                text: email,
              ),
              SizedBox(
                height: 30,
              ),
              _submitButton()
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
