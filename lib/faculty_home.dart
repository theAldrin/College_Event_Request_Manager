import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_consent2/Add_Info.dart';
import 'package:event_consent2/pending_events.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'calendar.dart';
import 'event_history.dart';
import 'event_request.dart';
import 'faculty_profile.dart';

class Facluty_home extends StatefulWidget {
  const Facluty_home({Key? key}) : super(key: key);

  @override
  State<Facluty_home> createState() => _Facluty_homeState();
}

final _firestore = FirebaseFirestore.instance;

class _Facluty_homeState extends State<Facluty_home> {
  final _auth = FirebaseAuth.instance;
  late String currentUserEmail;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        setState(() {
          currentUserEmail = user.email!;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  String formatString(String input) {
    List<String> parts = input.split('-'); // Split the input string by hyphens
    List<String> reversedParts =
        parts.reversed.toList(); // Reverse the order of the parts
    return reversedParts.join(
        '-'); // Join the reversed parts with hyphens and return the result
  }

  void updateEventStatusOfCompletedEvents() async {
    final events1 = await _firestore.collection("Event Request").get();
    for (var event in events1.docs) {
      DateTime eventEndTime = DateFormat("yyyy-MM-dd hh:mm:ss").parse(
          '${formatString(event.data()['Date']) + ' ' + event.data()['Event End Time']}:00');
      if (DateTime.now().isAfter(eventEndTime) &&
          event.data()['Status'] == 'ADMIN ACCEPTED') {
        await _firestore
            .collection('Event Request')
            .doc(event.id)
            .update({'Status': 'COMPLETED'});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    updateEventStatusOfCompletedEvents();
  }

  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          Pending_events(),
          Event_history(
            userType: 'FACULTY',
          ),
          Event_request(
            userType: 'FACULTY',
          ),
          Add_Info(userType: 'FACULTY'),
          Faculty_profile(
            facultyMail: currentUserEmail,
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        color: Color.fromRGBO(255, 255, 255, 1),
        controller: _controller,
        flat: false,
        useActiveColorByDefault: false,
        items: [
          RollingBottomBarItem(Icons.home_rounded,
              label: 'Pending', activeColor: Color(0xfff3892b)),
          RollingBottomBarItem(Icons.dock,
              label: 'History', activeColor: Color(0xfff3892b)),
          RollingBottomBarItem(Icons.add_box,
              label: 'Add', activeColor: Color(0xfff3892b)),
          RollingBottomBarItem(Icons.info,
              label: 'Info', activeColor: Color(0xfff3892b)),
          RollingBottomBarItem(Icons.person,
              label: 'Profile', activeColor: Color(0xfff3892b)),
        ],
        enableIconRotation: true,
        onTap: (index) {
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'calendar.dart';
// import 'faculty_profile.dart';
// import 'event_request.dart';
// import 'event_history.dart';
// import 'pending_events.dart';
//
// class Facluty_home extends StatefulWidget {
//   const Facluty_home({Key? key}) : super(key: key);
//
//   @override
//   State<Facluty_home> createState() => _Facluty_homeState();
// }
//
// class _Facluty_homeState extends State<Facluty_home> {
//   final _auth = FirebaseAuth.instance;
//   late String currentUserEmail;
//
//   void getCurrentUser() async {
//     try {
//       final user = await _auth.currentUser;
//       if (user != null) {
//         setState(() {
//           currentUserEmail = user.email!;
//         });
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getCurrentUser();
//   }
//
//   final _pageViewController = PageController();
//
//   int _activePage = 0;
//
//   @override
//   void dispose() {
//     _pageViewController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageViewController,
//         children: <Widget>[
//           Faculty_profile(
//             facultyMail: currentUserEmail,
//           ),
//           Event_history(
//             userType: 'FACULTY',
//           ),
//           Event_request(
//             userType: 'FACULTY',
//           ),
//           Pending_events(),
//           Calendar()
//         ],
//         onPageChanged: (index) {
//           setState(() {
//             _activePage = index;
//           });
//         },
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         unselectedItemColor: Colors.grey.shade400,
//         selectedItemColor: Color(0xfff3892b),
//         currentIndex: _activePage,
//         onTap: (index) {
//           _pageViewController.animateToPage(index,
//               duration: Duration(milliseconds: 20), curve: Curves.linear);
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.dock), label: "Event History"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.add_box), label: "Event Request"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.pending_actions), label: "Pending Events"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.calendar_month), label: "Calendar"),
//         ],
//       ),
//     );
//   }
// }
