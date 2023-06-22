import 'package:flutter/material.dart';
import 'components/bezierContainer.dart';
import 'student_registration.dart';
import 'faculty_registration.dart';
import 'administrator_registration.dart';

//selected user anusarich registration pagilekk ponath setta aknm

class Common_register extends StatefulWidget {
  const Common_register({Key? key}) : super(key: key);

  @override
  State<Common_register> createState() => _Common_registerState();
}

class _Common_registerState extends State<Common_register> {
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Event Hub',
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10)),
      ),
    );
  }

  Widget _submitButton() {
    return TextButton(
      onPressed: () {
        if (_selectedOption == 'STUDENT') {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Student_registration(),
              ));
        } else if (_selectedOption == 'FACULTY') {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Faculty_registration(),
              ));
        } else if (_selectedOption == 'ADMINISTRATOR') {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Administrator_registration(),
              ));
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
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
        child: Text(
          'Continue',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  String? _selectedOption = 'STUDENT';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _title(),
                  SizedBox(height: 50),
                  Text(
                    'Register As',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    iconEnabledColor: Color(0xfff7892b),
                    iconSize: 60,
                    value: _selectedOption,
                    items: <String>[
                      'STUDENT',
                      'FACULTY',
                      'ADMINISTRATOR',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // Change function parameter to nullable string
                      setState(() {
                        _selectedOption = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  _submitButton(),
                ],
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }
}
