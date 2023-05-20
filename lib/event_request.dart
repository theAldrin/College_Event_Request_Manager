import 'package:flutter/material.dart';

class Event_request extends StatefulWidget {
  const Event_request({Key? key}) : super(key: key);

  @override
  State<Event_request> createState() => _Event_requestState();
}

class _Event_requestState extends State<Event_request> {
  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Event Request',
          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)),
        ),
      ),
    );
  }

  //String? _selectedOption = 'STUDENT';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          // Positioned(
          //     top: -height * .15,
          //     right: -MediaQuery.of(context).size.width * .4,
          //     child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 90),
                  _title(),
                  SizedBox(height: 50),
                  _entryField('Event Name'),
                  SizedBox(height: 10),
                  _entryField('Date'),
                  SizedBox(height: 10),
                  _entryField('Event Start Time'),
                  SizedBox(height: 10),
                  _entryField('Event End Time'),
                  SizedBox(height: 10),
                  _entryField('Hall/Room'),
                  SizedBox(height: 10),
                  _entryField('Event Description'),
                  SizedBox(height: 10),
                  _entryField('Faculty Mail Id'),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SubmitButton(
                          text: 'VERIFY',
                          nextpage: Event_request(),
                          alertDialogText:
                              'Date, Time and Venue Verified'), //verify button functionality
                      SizedBox(
                        width: 20,
                      ),
                      SubmitButton(
                          text: 'SUBMIT',
                          nextpage: Event_request(),
                          alertDialogText:
                              'Event Request has been submitted succesfully'), //Submit button functionality
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
          //Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }
}

class SubmitButton extends StatelessWidget {
  //modification needed to include verify and submit buttons,,active inactive must be set as submit can only be presses after pressing verify
  SubmitButton(
      {required this.text,
      required this.nextpage,
      required this.alertDialogText});
  String text, alertDialogText;
  Widget nextpage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Expanded(
                child: AlertDialog(
                  title: Text(alertDialogText),
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
