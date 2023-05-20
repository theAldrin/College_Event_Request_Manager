import 'package:flutter/material.dart';
import 'student_profile_edit.dart';

class Student_Profile extends StatefulWidget {
  const Student_Profile({Key? key}) : super(key: key);

  @override
  State<Student_Profile> createState() => _Student_ProfileState();
}

class _Student_ProfileState extends State<Student_Profile> {
  Widget _submitButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Student_profile_edit(),
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
  }

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
                'Eren Yeagar',
                style: TextStyle(
                  //fontFamily: 'Pacifico',
                  fontSize: 40.0,
                  color: Color(0xfff3892b),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'STUDENT',
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
                text: 'TKM COLLEGE OF ENGINEERING',
              ),
              ProfileDetailsCard(
                icon: Icons.class_,
                text: 'CSE',
              ),
              ProfileDetailsCard(
                icon: Icons.holiday_village,
                text: 'R6B',
              ),
              ProfileDetailsCard(
                icon: Icons.party_mode,
                text: 'IEEE, IEDC',
              ),
              ProfileDetailsCard(
                icon: Icons.phone,
                text: '1313131313',
              ),
              ProfileDetailsCard(
                icon: Icons.email,
                text: 'orenonawaeren@gmail.com',
              ),
              SizedBox(
                height: 20,
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
  String text;
  IconData icon;
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
