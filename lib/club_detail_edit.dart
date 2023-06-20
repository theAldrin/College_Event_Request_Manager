import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Club_detail_edit extends StatefulWidget {
  Club_detail_edit({required this.clubDocumentID});

  final String clubDocumentID;

  @override
  State<Club_detail_edit> createState() => _Club_detail_editState();
}

final _firestore = FirebaseFirestore.instance;

class _Club_detail_editState extends State<Club_detail_edit> {
  void getData() async {
    var event =
        await _firestore.collection("Clubs").doc(widget.clubDocumentID).get();
    setState(() {
      name = event.data()?['Name'];
      facultyAdvisorName = event.data()?['Faculty Advisor Name'];
      facultyAdvisorMail = event.data()?['Faculty Advisor Email'];
    });
  }

  List<String> facultyNameList = ['Select'];
  List<String> facultyEmailList = ['Select'];

  void getallFaculties() async {
    final facultyData =
        await _firestore.collection('Faculty User Details').get();
    final faculties = facultyData.docs;
    for (var faculty1 in faculties) {
      setState(() {
        facultyEmailList.add(faculty1.data()['Email']);
        facultyNameList.add(faculty1.data()['Name']);
      });
    }
  }

  Widget facultyNameFromMailWidget(String facultyMail) {
    int i = -1;
    for (String facultyMail1 in facultyEmailList) {
      i++;
      if (facultyMail1 == facultyMail) {
        return Text(facultyNameList[i]);
      }
    }
    return Text('');
  }

  String facultyNameFromMailString(String facultyMail) {
    int i = -1;
    for (String facultyMail1 in facultyEmailList) {
      i++;
      if (facultyMail1 == facultyMail) {
        return facultyNameList[i];
      }
    }
    return ' ';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getallFaculties();
    getData();
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: name,
          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)),
        ),
      ),
    );
  }

  //String? _selectedOption = 'STUDENT';
  late String name = '',
      facultyAdvisorMail = 'Select',
      facultyAdvisorName = 'Select';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ))
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 25),
                    _title(),
                    SizedBox(height: 50),
                    Text(
                      'Faculty Advisor Mail',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButton<String>(
                      isExpanded: true,
                      iconEnabledColor: Color(0xfff7892b),
                      iconSize: 30,
                      value: facultyAdvisorMail,
                      items: facultyEmailList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: facultyNameFromMailWidget(
                              value), //Find faculty based on email here
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // Change function parameter to nullable string
                        setState(() {
                          facultyAdvisorMail = newValue!;
                          facultyAdvisorName =
                              facultyNameFromMailString(facultyAdvisorMail);
                        });
                      },
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await _firestore
                                .collection('Clubs')
                                .doc(widget.clubDocumentID)
                                .update({
                              'Faculty Advisor Name': facultyAdvisorName,
                              'Faculty Advisor Email': facultyAdvisorMail
                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Expanded(
                                  child: AlertDialog(
                                    title: Text(
                                        'Club details updated Succesfully'),
                                    // content: Text('GeeksforGeeks'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          //Navigator.pop(context);//error
                                          //Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            'OK',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _firestore
                                .collection('Clubs')
                                .doc(widget.clubDocumentID)
                                .delete();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Expanded(
                                  child: AlertDialog(
                                    title: Text(
                                        'Club details Deleted Succesfully'),
                                    // content: Text('GeeksforGeeks'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          //Navigator.pop(context);//error
                                          //Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            'OK',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
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
                                'DELETE',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 60),
                  ],
                ),
              ),
            ],
          ),
          //Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }
}
