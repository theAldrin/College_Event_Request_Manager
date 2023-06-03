import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_consent2/administrator_profile_edit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Administrator_profile extends StatefulWidget {
  Administrator_profile({required this.adminMail});
  String adminMail;

  @override
  State<Administrator_profile> createState() => _Administrator_profileState();
}

final _firestore = FirebaseFirestore.instance;
dynamic loggedInUser;

class _Administrator_profileState extends State<Administrator_profile> {
  final _auth = FirebaseAuth.instance;
  String currentUserEmail = '';

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        currentUserEmail = user.email!;
      }
    } catch (e) {
      print(e);
    }
  }

  void getData() async {
    await for (var snapshot
        in _firestore.collection('Administrator User Details').snapshots()) {
      for (var user in snapshot.docs) {
        if (widget.adminMail == user.data()['Email']) {
          setState(() {
            name = user.data()['Name'];
            college = user.data()['College'];
            email = user.data()['Email'];
            phoneno = user.data()['Phone No'];
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getData();
  }

  Widget _submitButton() {
    if (currentUserEmail == widget.adminMail) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Administrator_profile_edit(),
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

  String name = '', college = '', email = '', phoneno = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //backgroundColor: Color(0xfff3892b),
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
                'ADMINISTRATOR',
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
                icon: Icons.phone,
                text: phoneno,
              ),
              ProfileDetailsCard(
                icon: Icons.email,
                text: email,
              ),
              SizedBox(
                height: 50,
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
