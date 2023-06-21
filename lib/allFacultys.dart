import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_consent2/faculty_profile.dart';
import 'package:flutter/material.dart';

class allFcaultys extends StatefulWidget {
  const allFcaultys({Key? key}) : super(key: key);

  @override
  State<allFcaultys> createState() => _allFcaultysState();
}

final _firestore = FirebaseFirestore.instance;

class _allFcaultysState extends State<allFcaultys> {
  Widget _title() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Faculties',
          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)),
        ),
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10, 46, 0, 30),
                child: _title(),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FacultyCard extends StatelessWidget {
  FacultyCard(
      {required this.name,
      required this.position,
      required this.department,
      required this.club,
      required this.facultyMail});
  String name, department, position, club, facultyMail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Faculty_profile(facultyMail: facultyMail),
              ));
        },
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
          margin: EdgeInsets.fromLTRB(2, 0, 2, 10),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 10, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   width: 20,
                // ),
                Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  position.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black54),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Department: ' + department,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Clubs: ' + club,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.black),
                ),
                // SizedBox(
                //   height: 7,
                // ),
              ],
            ),
          ),
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
        stream: _firestore.collection('Faculty User Details').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final venues = snapshot.data?.docs.reversed;
          List<FacultyCard> VenueList = [];
          for (var venue in venues!) {
            if (venue
                    .data()['Name']
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                venue
                    .data()['Clubs']
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                venue
                    .data()['Position']
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                venue
                    .data()['Department']
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                venue
                    .data()['Email']
                    .toLowerCase()
                    .contains(searchText.toLowerCase())) {
              VenueList.add(FacultyCard(
                name: venue.data()['Name'],
                position: venue.data()['Position'],
                department: venue.data()['Department'],
                club: venue.data()['Clubs'],
                facultyMail: venue.data()['Email'],
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
