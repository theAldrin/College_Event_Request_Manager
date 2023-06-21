import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_consent2/venue_detail_edit.dart';
import 'package:flutter/material.dart';

import 'department_detail_edit.dart';

class Department extends StatefulWidget {
  Department({required this.userType});
  String userType;
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
                                child: AddDepartmentScreen(),
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

class DepartmentCard extends StatelessWidget {
  DepartmentCard(
      {required this.departmentName,
      required this.hodName,
      required this.departmentDocumentID,
      required this.hodEmail,
      required this.userType});
  String departmentName;
  String hodName, hodEmail, departmentDocumentID, userType;

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        departmentName,
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'HOD ',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Name: ' + hodName.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.black54),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Email: ' + hodEmail.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.black54),
                    ),
                  ],
                ),
              ),
              userType == 'ADMINISTRATOR'
                  ? Expanded(
                      flex: 1,
                      child: Padding(
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
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

class AddDepartmentScreen extends StatefulWidget {
  @override
  State<AddDepartmentScreen> createState() => _AddDepartmentScreenState();
}

class _AddDepartmentScreenState extends State<AddDepartmentScreen> {
  late String clubName, HODMail = 'Select', HODName = 'Select';

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

  @override
  void initState() {
    super.initState();
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
                'Add Department',
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
                    clubName = value;
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
                value: HODMail,
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
                    HODMail = newValue!;
                    HODName = facultyNameFromMailString(HODMail);
                  });
                },
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  await _firestore.collection('Departments').add({
                    'Name': clubName,
                    'HOD Email': HODMail,
                    'HOD Name': HODName,
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
                    .data()['HOD Name']
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                department
                    .data()['HOD Email']
                    .toLowerCase()
                    .contains(searchText.toLowerCase())) {
              DepartmentList.add(DepartmentCard(
                departmentName: department.data()['Name'],
                departmentDocumentID: department.id,
                hodName: department.data()['HOD Name'],
                hodEmail: department.data()['HOD Email'],
                userType: userType,
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
