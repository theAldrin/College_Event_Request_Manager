import 'package:event_consent2/administrator_profile_edit.dart';
import 'package:flutter/material.dart';

class Administrator_profile extends StatefulWidget {
  const Administrator_profile({Key? key}) : super(key: key);

  @override
  State<Administrator_profile> createState() => _Administrator_profileState();
}

class _Administrator_profileState extends State<Administrator_profile> {
  Widget _submitButton() {
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
                text: 'TKM COLLEGE OF ENGINEERING',
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
