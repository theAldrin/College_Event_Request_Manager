import 'package:event_consent2/calendar.dart';
import 'package:flutter/material.dart';
import 'student_profile.dart';
import 'event_request.dart';
import 'event_history.dart';

class Student_home extends StatefulWidget {
  const Student_home({Key? key}) : super(key: key);

  @override
  State<Student_home> createState() => _Student_homeState();
}

class _Student_homeState extends State<Student_home> {
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
          Student_Profile(),
          Event_history(),
          Event_request(),
          Calendar()
        ],
        onPageChanged: (index) {
          setState(() {
            _activePage = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Color(0xfff3892b),
        unselectedItemColor: Colors.grey.shade400,
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
              icon: Icon(Icons.calendar_month), label: "Calendar"),
        ],
      ),
    );
  }
}
