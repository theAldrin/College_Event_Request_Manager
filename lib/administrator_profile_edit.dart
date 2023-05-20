import 'package:flutter/material.dart';

class Administrator_profile_edit extends StatefulWidget {
  const Administrator_profile_edit({Key? key}) : super(key: key);

  @override
  State<Administrator_profile_edit> createState() =>
      _Administrator_profile_editState();
}

class _Administrator_profile_editState
    extends State<Administrator_profile_edit> {
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
          text: 'Edit your Profile',
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
                  _entryField('Phone No'),
                  SizedBox(height: 10),
                  _entryField('Mail Id'),
                  SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Expanded(
                            child: AlertDialog(
                              title: Text('Profile Updated Succesfully'),
                              // content: Text('GeeksforGeeks'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Go to Profile',
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
                          color: Colors.black),
                      child: Center(
                        child: Text(
                          'UPDATE',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
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
