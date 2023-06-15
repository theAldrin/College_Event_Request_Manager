import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_consent2/venue_detail_edit.dart';
import 'package:flutter/material.dart';

import 'department_detail_edit.dart';

class Department extends StatefulWidget {
  const Department({Key? key}) : super(key: key);

  @override
  State<Department> createState() => _DepartmentState();
}

final _firestore = FirebaseFirestore.instance;

class _DepartmentState extends State<Department> {
  Widget _title() {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        text: 'Departments',
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
                    margin: EdgeInsets.fromLTRB(15, 40, 0, 30),
                    child: _title(),
                  ),
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => SingleChildScrollView(
                            child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom +
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
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DepartmentCard extends StatelessWidget {
  DepartmentCard(
      {required this.departmentName,
      required this.hod,
      required this.departmentDocumentID});
  String departmentName;
  String hod, departmentDocumentID;

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
                        departmentName,
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Capacity: ' + hod.toString(),
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
                              builder: (context) => Department_detail_edit(
                                departmentDocumentID: departmentDocumentID,
                              ),
                            ));
                      },
                      child: Container(
                        //margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        width: 70,
                        padding: EdgeInsets.symmetric(vertical: 7),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
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
  late String departmentName, hod = 'ADMINISTRATOR';

  List<String> facultyList = ['ADMINISTRATOR'];
  void getallFaculties() async {
    final facultyData =
        await _firestore.collection('Faculty User Details').get();
    final faculties = facultyData.docs;
    for (var faculty1 in faculties) {
      setState(() {
        facultyList.add(faculty1.data()['Name']);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getallFaculties();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              'Add Deaprtment',
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
                  departmentName = value;
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true)),
            SizedBox(
              height: 20,
            ),
            Text(
              'HOD',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButton<String>(
              isExpanded: true,
              iconEnabledColor: Color(0xfff7892b),
              iconSize: 60,
              value: hod,
              items: facultyList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Change function parameter to nullable string
                setState(() {
                  hod = newValue!;
                });
              },
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                await _firestore.collection('Departments').add({
                  'Name': departmentName,
                  'HOD': hod,
                });
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Expanded(
                      child: AlertDialog(
                        title: Text('Department Added Succesfully'),
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
  MessageStream({required this.searchText});
  final String searchText;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore.collection('Departments').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final departments = snapshot.data?.docs.reversed;
          List<DepartmentCard> DepartmentList = [];
          for (var department in departments!) {
            if (department
                    .data()['Name']
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                department
                    .data()['HOD']
                    .toLowerCase()
                    .contains(searchText.toLowerCase())) {
              DepartmentList.add(DepartmentCard(
                departmentName: department.data()['Name'],
                hod: department.data()['HOD'],
                departmentDocumentID: department.id,
              ));
            }
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
              children: DepartmentList,
            ),
          );
        });
  }
}
