import 'package:event_consent2/departments.dart';
import 'package:event_consent2/venues.dart';
import 'package:flutter/material.dart';

import 'package:event_consent2/clubs.dart';

class Add_Info extends StatefulWidget {
  const Add_Info({Key? key}) : super(key: key);

  @override
  State<Add_Info> createState() => _Add_InfoState();
}

class _Add_InfoState extends State<Add_Info> {
  Widget _title() {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        text: 'Information',
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(15, 40, 0, 30),
                child: _title(),
              ),
              SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                child: Column(
                  //padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                  children: [
                    InfoCard(
                      infoType: 'Venues',
                      onPressed: Venues(),
                    ),
                    InfoCard(
                      infoType: 'Departments',
                      onPressed: Department(),
                    ),
                    InfoCard(
                      infoType: 'Clubs',
                      onPressed: Clubs(),
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
  final Widget onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => onPressed));
        },
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
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 10, 20),
            child: Row(
              children: [
                Container(
                  child: Text(
                    infoType,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
