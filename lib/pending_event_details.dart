import 'package:flutter/material.dart';
import 'faculty_profile.dart';

class Pending_Event_Details extends StatefulWidget {
  const Pending_Event_Details({Key? key}) : super(key: key);

  @override
  State<Pending_Event_Details> createState() => _Pending_Event_DetailsState();
}

class _Pending_Event_DetailsState extends State<Pending_Event_Details> {
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Flutter Workshop',
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10)),
      ),
    );
  }

  String? _selectedOption = 'Rohit Manoj Kumar';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFF8F4F2),
        body: SafeArea(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(15, 40, 0, 30),
                child: _title(),
                width: double.infinity,
              ),
              Event_Detail_Column(
                id: '101',
                date: '01 NOV 23',
                student: 'Akash',
                event_start_time: '10 am',
                event_end_time: '4 pm',
                venue: 'M 101',
                description:
                    'For giving the students an hands on training on how to develop Flutter Apps.Conducted By : Abhiram (CEO of Edtech)',
                faculties_involved: [
                  'Aslah Koyathangal',
                  'Roshan Parambiladan',
                  'Rohit Manoj Kumar',
                  'Adarsh M S'
                ],
                isCompleted: true,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Color(0xfff7892b),
                  child: InkWell(
                    onTap: () {
                      // Action to perform when the button is pressed
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Expanded(
                            child: AlertDialog(
                              title: Text('Date Time and Venue verified'),
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
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'VERIFY',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Forward To',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButton<String>(
                isExpanded: true,
                iconEnabledColor: Color(0xfff7892b),
                iconSize: 60,
                value: _selectedOption,
                items: <String>[
                  'Aslah Koyathangal',
                  'Roshan Parambiladan',
                  'Rohit Manoj Kumar',
                  'Adarsh Avoli'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Change function parameter to nullable string
                  setState(() {
                    _selectedOption = newValue;
                  });
                },
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Color(0xfff7892b),
                  child: InkWell(
                    onTap: () {
                      // Action to perform when the button is pressed
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Expanded(
                            child: AlertDialog(
                              title: Text('Event request forwarded'),
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
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'FORWARD',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'OR',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Color(0xfff7892b),
                  child: InkWell(
                    onTap: () {
                      // Action to perform when the button is pressed
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Expanded(
                            child: AlertDialog(
                              title: Text('ATTENTION !!!'),
                              content: Text(
                                  'Are you sure you have the authority to give final accept this event request'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Expanded(
                                          child: AlertDialog(
                                            title: Text(
                                                'Do you want to give final accept to this event Request'),
                                            //content: Text('Are you sure you have the authority to give final accept this event request'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Expanded(
                                                        child: AlertDialog(
                                                          title: Text(
                                                              'Final accept for the event is provided'),
                                                          //content: Text('Are you sure you have the authority to give final accept this event request'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                child: Text(
                                                                  'OK',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                color: Colors
                                                                    .black,
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
                                                    'YES',
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
                                      'YES',
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
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'FINAL ACCEPT',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ]),
          ),
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

  final List<String> faculties_involved;
  final bool isCompleted;

  List<Widget> facultylist(BuildContext context) {
    List<Widget> FacultiesInvolvedList = [];

    for (String faculty in faculties_involved) {
      if (faculties_involved.last != faculty) {
        FacultiesInvolvedList.add(TextButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              builder: (context) => Faculty_profile(),
            ));
          },
          child: Text(
            faculty,
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
          'FACULTIES ALREADY APPROVED:',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          children: facultylist(context),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class SubmitButton extends StatelessWidget {
  SubmitButton({required this.text, required this.nextpage});
  String text;
  Widget nextpage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => nextpage,
              ));
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
                  colors: [Color(0xfffbb448), Color(0xfff7892b)])),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
