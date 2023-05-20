import 'package:flutter/material.dart';
import 'calendar.dart';
import 'faculty_profile.dart';
import 'event_request.dart';
import 'event_history.dart';
import 'pending_events.dart';

class Facluty_home extends StatefulWidget {
  const Facluty_home({Key? key}) : super(key: key);

  @override
  State<Facluty_home> createState() => _Facluty_homeState();
}

class _Facluty_homeState extends State<Facluty_home> {
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
          Faculty_profile(),
          Event_history(),
          Event_request(),
          Pending_events(),
          Calendar()
        ],
        onPageChanged: (index) {
          setState(() {
            _activePage = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey.shade400,
        selectedItemColor: Color(0xfff3892b),
        currentIndex: _activePage,
        onTap: (index) {
          _pageViewController.animateToPage(index,
              duration: Duration(milliseconds: 20), curve: Curves.linear);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(Icons.dock), label: "Event History"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box), label: "Event Request"),
          BottomNavigationBarItem(
              icon: Icon(Icons.pending_actions), label: "Pending Events"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Calendar"),
        ],
      ),
    );
  }
}
