import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Venue_detail_edit extends StatefulWidget {
  Venue_detail_edit({required this.venueDocumentID});

  final String venueDocumentID;

  @override
  State<Venue_detail_edit> createState() => _Venue_detail_editState();
}

final _firestore = FirebaseFirestore.instance;

class _Venue_detail_editState extends State<Venue_detail_edit> {
  void getData() async {
    var event =
        await _firestore.collection("Venues").doc(widget.venueDocumentID).get();
    setState(() {
      name = event.data()?['Name'];
      type = event.data()?['Type'];
      department = event.data()?['Department'];
      capacity = event.data()?['Capacity'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
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
  late String type = 'CLASS',
      capacity = '',
      department = 'COMPUTER SCIENCE',
      name = '';
  List<String> venueTypes = ['CLASS', 'HALL', 'AUDITORIUM', 'OUTDOORS', 'LAB'];

  List<String> departments = [
    'COMPUTER SCIENCE',
    'MECHANICAL',
    'CHEMICAL',
    'ELECTRICAL AND ELECTRONICAL',
    'ELECTRONICS AND COMMUNICATION',
    'CIVIL'
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
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
                  Text(
                    'TYPE',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    iconEnabledColor: Color(0xfff7892b),
                    iconSize: 60,
                    value: type,
                    items: venueTypes
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // Change function parameter to nullable string
                      setState(() {
                        type = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Department',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    iconEnabledColor: Color(0xfff7892b),
                    iconSize: 60,
                    value: department,
                    items: departments
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // Change function parameter to nullable string
                      setState(() {
                        department = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 25),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Capacity',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                            onChanged: (value) {
                              capacity = value;
                            },
                            decoration: InputDecoration(
                                hintText: capacity,
                                border: InputBorder.none,
                                fillColor: Color(0xfff3f3f4),
                                filled: true))
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await _firestore
                              .collection('Venues')
                              .doc(widget.venueDocumentID)
                              .update({
                            'Department': department,
                            'Type': type,
                            'Capacity': capacity
                          });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Expanded(
                                child: AlertDialog(
                                  title:
                                      Text('Venue details updated Succesfully'),
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await _firestore
                              .collection('Venues')
                              .doc(widget.venueDocumentID)
                              .delete();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Expanded(
                                child: AlertDialog(
                                  title:
                                      Text('Venue details Deleted Succesfully'),
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
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
          ),
          //Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }
}
