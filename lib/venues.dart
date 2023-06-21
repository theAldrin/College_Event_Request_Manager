import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_consent2/venue_detail_edit.dart';
import 'package:flutter/material.dart';

class Venues extends StatefulWidget {
  Venues({required this.userType});
  String userType;
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

  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        // floatingActionButton: FloatingActionButton(
        //   clipBehavior: Clip.antiAliasWithSaveLayer,
        //   backgroundColor: Color(0xffe46b10),
        //   child: Icon(
        //     Icons.add,
        //     size: 30,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {
        //     showModalBottomSheet(
        //       isScrollControlled: true,
        //       context: context,
        //       builder: (context) => SingleChildScrollView(
        //           child: Container(
        //         padding: EdgeInsets.only(
        //             bottom: MediaQuery.of(context).viewInsets.bottom + 30),
        //         child: AddVenueScreen(),
        //       )),
        //     );
        //   },
        // ),
        backgroundColor: Color(0xffffffff),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 46, 0, 30),
                    child: _title(),
                  ),
                  widget.userType == 'ADMINISTRATOR'
                      ? TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => SingleChildScrollView(
                                  child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom +
                                        30),
                                child: AddVenueScreen(),
                              )),
                            );
                          },
                          child: Icon(
                            Icons.add,
                            size: 35,
                            color: Color(0xffe46b10),
                          ),
                        )
                      : Container()
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    // style: ,
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                    decoration: InputDecoration(
                        focusColor: Colors.grey,
                        contentPadding: EdgeInsets.zero,
                        hintText: "Search",
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(width: 4)),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 15,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MessageStream(
                searchText: _searchText,
                userType: widget.userType,
              )
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
      required this.venueDocumentID,
      required this.facultyName,
      required this.facultyMail,
      required this.userType});
  String venueName,
      department,
      capacity,
      venueDocumentID,
      facultyName,
      facultyMail,
      userType;
  String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
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
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 10, 20),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        venueName,
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        type,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                    ],
                  ),
                  userType == 'ADMINISTRATOR'
                      ? Padding(
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
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
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Capacity: ' + capacity.toString(),
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
              SizedBox(
                height: 10,
              ),
              Text(
                'Faculty in charge:',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Name: ' + facultyName.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.black54),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Email: ' + facultyMail.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.black54),
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
      newVenueDepartment = 'NONE',
      newVenueCapacity = '',
      newVenueFacultyName = 'Select',
      newVenueFacultyMail = 'Select';

  List<String> venueTypes = ['CLASS', 'HALL', 'AUDITORIUM', 'OUTDOORS', 'LAB'];

  List<String> departments = [
    'NONE',
    'COMPUTER SCIENCE',
    'MECHANICAL',
    'CHEMICAL',
    'ELECTRICAL AND ELECTRONICAL',
    'ELECTRONICS AND COMMUNICATION',
    'CIVIL'
  ];

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

  void getAdmin() async {
    final adminData =
        await _firestore.collection('Administrator User Details').get();
    final admins = adminData.docs;
    for (var admin1 in admins) {
      setState(() {
        facultyEmailList.add(admin1.data()['Email']);
        facultyNameList.add('ADMINISTRATOR');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //getAdmin();
    getallFaculties();
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color(0xFF757575),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          padding: EdgeInsets.fromLTRB(40, 45, 40, 0),
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
                items:
                    departments.map<DropdownMenuItem<String>>((String value) {
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
                'Handling Faculty',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButton<String>(
                isExpanded: true,
                iconEnabledColor: Color(0xfff7892b),
                iconSize: 60,
                value: newVenueFacultyMail,
                items: facultyEmailList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: facultyNameFromMailWidget(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Change function parameter to nullable string
                  setState(() {
                    newVenueFacultyMail = newValue!;
                    newVenueFacultyName =
                        facultyNameFromMailString(newVenueFacultyMail);
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
                  await _firestore.collection('Venues').add({
                    'Name': newVenueName,
                    'Type': newVenueType,
                    'Department': newVenueDepartment,
                    'Capacity': newVenueCapacity,
                    'Faculty Email': newVenueFacultyMail,
                    'Faculty Name': newVenueFacultyName
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
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  MessageStream({required this.searchText, required this.userType});
  final String searchText, userType;

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
            if (venue
                    .data()['Name']
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                venue
                    .data()['Type']
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                venue
                    .data()['Capacity']
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                venue
                    .data()['Department']
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                venue
                    .data()['Faculty Email']
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                venue
                    .data()['Faculty Name']
                    .toLowerCase()
                    .contains(searchText.toLowerCase())) {
              VenueList.add(VenueCard(
                venueName: venue.data()['Name'],
                type: venue.data()['Type'],
                capacity: venue.data()['Capacity'],
                department: venue.data()['Department'],
                venueDocumentID: venue.id,
                facultyName: venue.data()['Faculty Name'],
                facultyMail: venue.data()['Faculty Email'],
                userType: userType,
              ));
            }
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
