import 'package:flutter/material.dart';
import 'faculty_profile.dart';

class Student_event_details extends StatefulWidget {
  Student_event_details(
      {required this.name,
      required this.id,
      required this.date,
      required this.student,
      required this.eventStartTime,
      required this.eventEndTime,
      required this.venue,
      required this.description,
      required this.facultiesInvolved});
  String id,
      date,
      student,
      eventStartTime,
      eventEndTime,
      venue,
      description,
      name;
  List<dynamic> facultiesInvolved;

  @override
  State<Student_event_details> createState() => _Student_event_detailsState();
}

class _Student_event_detailsState extends State<Student_event_details> {
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: widget.name,
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
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
                  id: widget.id,
                  date: widget.date,
                  student: widget.student,
                  event_start_time: widget.eventStartTime,
                  event_end_time: widget.eventEndTime,
                  venue: widget.venue,
                  description: widget.description,
                  faculties_involved: widget.facultiesInvolved,
                  isCompleted: false,
                )
              ]),
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
      required this.isCompleted});

  final String id,
      date,
      student,
      event_start_time,
      event_end_time,
      venue,
      description;

  final List<dynamic> faculties_involved;
  final bool isCompleted;

  Widget _submitButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Expanded(
              child: AlertDialog(
                title: Text('Event Request is withdrawn succesfully'),
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
              ),
            );
          },
        );
      },
      child: Container(
        width: double.infinity,
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
          'WITHDRAW REQUEST',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget bottompart(BuildContext context) {
    String currentOrFinal;
    Widget lastButton;
    if (isCompleted == false) {
      currentOrFinal = 'Current Faculty :';
      lastButton = _submitButton(context);
    } else {
      currentOrFinal = 'Final Accept By :';
      lastButton = Text('');
    }
    return Column(
      children: [
        Text(
          currentOrFinal,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Faculty_profile(),
                ));
          },
          child: Text(
            faculties_involved.last,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Colors.blueAccent),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        lastButton,
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  List<Widget> facultylist(BuildContext context) {
    List<Widget> FacultiesInvolvedList = [];

    for (dynamic faculty in faculties_involved) {
      if (faculties_involved.last.toString() != faculty.toString()) {
        FacultiesInvolvedList.add(TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Faculty_profile(),
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
    return Column(
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
          'STUDENT : ' + student,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
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
          'FACULTIES INVOLVED:',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          children: facultylist(
              context), //returns text widgets of all the faculties involved except the last
        ),
        SizedBox(
          height: 20,
        ),
        bottompart(
            context) //returns the last faculty current faculty/final accept giving faculty
      ],
    );
  }
}
