import 'package:event_consent2/venues.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';

import 'admininstrator_profile.dart';
import 'all_events.dart';
import 'calendar.dart';
import 'event_request.dart';

class Administrator_home extends StatefulWidget {
  const Administrator_home({Key? key}) : super(key: key);

  @override
  State<Administrator_home> createState() => _Administrator_homeState();
}

class _Administrator_homeState extends State<Administrator_home> {
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

  @override
  void initState() {
    super.initState();
    getCurrentUser();
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
          Administrator_profile(
            adminMail: currentUserEmail,
          ),
          All_events(),
          Event_request(
            userType: 'ADMINISTRATOR',
          ),
          Venues(),
          Calendar()
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        color: Color.fromRGBO(255, 255, 255, 1),
        controller: _controller,
        flat: false,
        useActiveColorByDefault: false,
        items: [
          RollingBottomBarItem(Icons.person,
              label: 'Profile', activeColor: Color(0xfff3892b)),
          RollingBottomBarItem(Icons.dock,
              label: 'All Events', activeColor: Color(0xfff3892b)),
          RollingBottomBarItem(Icons.add_box,
              label: 'Add Event', activeColor: Color(0xfff3892b)),
          RollingBottomBarItem(Icons.home_rounded,
              label: 'Venues', activeColor: Color(0xfff3892b)),
          RollingBottomBarItem(Icons.calendar_month,
              label: 'Calendar', activeColor: Color(0xfff3892b)),
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

// import 'package:event_consent2/calendar.dart';
// import 'package:event_consent2/event_request.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'admininstrator_profile.dart';
// import 'all_events.dart';
// import 'venues.dart';
//
// class Administrator_home extends StatefulWidget {
//   const Administrator_home({Key? key}) : super(key: key);
//
//   @override
//   State<Administrator_home> createState() => _Administrator_homeState();
// }
//
// class _Administrator_homeState extends State<Administrator_home> {
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
//           Administrator_profile(
//             adminMail: currentUserEmail,
//           ),
//           All_events(),
//           Event_request(
//             userType: 'ADMINISTRATOR',
//           ),
//           Venues(),
//           Calendar()
//         ],
//         onPageChanged: (index) {
//           setState(() {
//             _activePage = index;
//           });
//         },
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Color(0xfff3892b),
//         unselectedItemColor: Colors.grey.shade400,
//         currentIndex: _activePage,
//         onTap: (index) {
//           _pageViewController.animateToPage(index,
//               duration: Duration(milliseconds: 20), curve: Curves.linear);
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//           BottomNavigationBarItem(icon: Icon(Icons.dock), label: "All Events"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.add_box), label: "Event Request"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.home_rounded), label: "Venues"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.calendar_month), label: "Calendar"),
//         ],
//       ),
//     );
//   }
// }
