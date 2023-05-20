import 'package:event_consent2/calendar.dart';
import 'package:event_consent2/event_request.dart';
import 'package:flutter/material.dart';
import 'admininstrator_profile.dart';
import 'all_events.dart';
import 'venues.dart';

class Administrator_home extends StatefulWidget {
  const Administrator_home({Key? key}) : super(key: key);

  @override
  State<Administrator_home> createState() => _Administrator_homeState();
}

class _Administrator_homeState extends State<Administrator_home> {
  final _pageViewController = PageController();

  int _activePage = 0;

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageViewController,
        children: <Widget>[
          Administrator_profile(),
          All_events(),
          Event_request(),
          Venues(),
          Calendar()
        ],
        onPageChanged: (index) {
          setState(() {
            _activePage = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xfff3892b),
        unselectedItemColor: Colors.grey.shade400,
        currentIndex: _activePage,
        onTap: (index) {
          _pageViewController.animateToPage(index,
              duration: Duration(milliseconds: 20), curve: Curves.linear);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.dock), label: "All Events"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box), label: "Event Request"),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: "Venues"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Calendar"),
        ],
      ),
    );
  }
}
