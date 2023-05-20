import 'package:flutter/material.dart';
import 'venue_details.dart';

class Venues extends StatefulWidget {
  const Venues({Key? key}) : super(key: key);

  @override
  State<Venues> createState() => _VenuesState();
}

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
        backgroundColor: Color(0x0ff3892b),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(15, 40, 0, 30),
                  child: _title(),
                  width: double.infinity,
                ),
                VenueCard(
                  venueName: 'M101',
                  type: 'CLASS',
                  capacity: 80,
                  nextPage: Venue_details(),
                ),
                VenueCard(
                  venueName: 'C101',
                  type: 'CLASS',
                  capacity: 80,
                  nextPage: Venue_details(),
                ),
                VenueCard(
                  venueName: 'APJ',
                  type: 'HALL',
                  capacity: 80,
                  nextPage: Venue_details(),
                ),
                VenueCard(
                  venueName: 'MAIN',
                  type: 'AUDITORIUM',
                  capacity: 500,
                  nextPage: Venue_details(),
                ),
                VenueCard(
                  venueName: 'APJ PARK',
                  type: 'OUTDOORS',
                  capacity: 200,
                  nextPage: Venue_details(),
                ),
                VenueCard(
                  venueName: 'M200',
                  type: 'CLASS',
                  capacity: 80,
                  nextPage: Venue_details(),
                )
              ],
            ),
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
      required this.nextPage});
  String venueName;
  String type;
  int capacity;
  Widget nextPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Venue_details(),
            ));
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // SizedBox(
              //   width: 20,
              // ),
              Expanded(
                child: Text(
                  venueName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),
              ),
              Expanded(
                child: Text(
                  type,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),
              ),
              // SizedBox(
              //   height: 7,
              // ),
              Expanded(
                child: Text(
                  'Capacity: ' + capacity.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),
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
