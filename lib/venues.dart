import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_consent2/venue_detail_edit.dart';
import 'package:flutter/material.dart';

class Venues extends StatefulWidget {
  const Venues({Key? key}) : super(key: key);

  @override
  State<Venues> createState() => _VenuesState();
}

final _firestore = FirebaseFirestore.instance;

class _VenuesState extends State<Venues> {
  Widget _title() {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        text: 'Venues',
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffe46b10),
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => SingleChildScrollView(
                  child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 30),
                child: AddVenueScreen(),
              )),
            );
          },
        ),
        backgroundColor: Color(0xffffffff),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(15, 40, 0, 30),
                child: _title(),
                width: double.infinity,
              ),
              MessageStream()
            ],
          ),
        ),
      ),
    );
  }
}

class VenueCard extends StatelessWidget {
  VenueCard(
      {required this.venueName,
      required this.type,
      required this.capacity,
      required this.department,
      required this.venueDocumentID});
  String venueName, department, capacity, venueDocumentID;
  String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          // border: Border.all(
          //   color: Colors.grey,
          //   width: 0,
          // ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4.0,
              spreadRadius: 0,
            ),
          ],
        ),
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   width: 20,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        venueName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        type,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Venue_detail_edit(
                                venueDocumentID: venueDocumentID,
                              ),
                            ));
                      },
                      child: Container(
                        //margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        width: 70,
                        padding: EdgeInsets.symmetric(vertical: 7),
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
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Capacity: ' + capacity.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Department: ' + department,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              ),
              // SizedBox(
              //   height: 7,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddVenueScreen extends StatefulWidget {
  @override
  State<AddVenueScreen> createState() => _AddVenueScreenState();
}

class _AddVenueScreenState extends State<AddVenueScreen> {
  late String newVenueName = '',
      newVenueType = 'CLASS',
      newVenueDepartment = 'COMPUTER SCIENCE',
      newVenueCapacity = '';

  List<String> venueTypes = ['CLASS', 'HALL', 'AUDITORIUM', 'OUTDOORS'];

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
    return Container(
      color: Color(0xFF757575),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        padding: EdgeInsets.fromLTRB(40, 30, 40, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Venue',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 35),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Name',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
                onChanged: (value) {
                  newVenueName = value;
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true)),
            SizedBox(
              height: 20,
            ),
            Text(
              'Type',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButton<String>(
              isExpanded: true,
              iconEnabledColor: Color(0xfff7892b),
              iconSize: 60,
              value: newVenueType,
              items: venueTypes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Change function parameter to nullable string
                setState(() {
                  newVenueType = newValue!;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Department',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButton<String>(
              isExpanded: true,
              iconEnabledColor: Color(0xfff7892b),
              iconSize: 60,
              value: newVenueDepartment,
              items: departments.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Change function parameter to nullable string
                setState(() {
                  newVenueDepartment = newValue!;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Capacity',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
                onChanged: (value) {
                  newVenueCapacity = value;
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true)),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                print('oi');
                await _firestore.collection('Venues').add({
                  'Name': newVenueName,
                  'Type': newVenueType,
                  'Department': newVenueDepartment,
                  'Capacity': newVenueCapacity,
                });
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Expanded(
                      child: AlertDialog(
                        title: Text('Venue Added Succesfully'),
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
                height: 60,
                color: Color(0xffe46b10),
                child: Center(
                    child: Text(
                  'Add',
                  style: TextStyle(fontSize: 26, color: Colors.white),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore.collection('Venues').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final venues = snapshot.data?.docs.reversed;
          List<VenueCard> VenueList = [];
          for (var venue in venues!) {
            VenueList.add(VenueCard(
              venueName: venue.data()['Name'],
              type: venue.data()['Type'],
              capacity: venue.data()['Capacity'],
              department: venue.data()['Department'],
              venueDocumentID: venue.id,
            ));
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
              children: VenueList,
            ),
          );
        });
  }
}
