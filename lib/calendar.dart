import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_consent2/administrator_event_details.dart';
import 'package:event_consent2/student_faculty_event_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  Calendar({required this.userType});
  String userType;

  @override
  State<Calendar> createState() => _CalendarState();
}

final _firestore = FirebaseFirestore.instance;

class _CalendarState extends State<Calendar> {
  var events;
  void getEventDetails() async {
    final events1 = await _firestore.collection("Event Request").get();
    setState(() {
      events = events1.docs;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEventDetails();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppointmentDetails(
        events: events,
        userType: widget.userType,
      ),
    );
  }
}

class AppointmentDetails extends StatefulWidget {
  AppointmentDetails(
      {super.key, @required this.events, required this.userType});
  var events;
  String userType;
  @override
  State<StatefulWidget> createState() => ScheduleExample();
}

class ScheduleExample extends State<AppointmentDetails> {
  Widget _title() {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        text: 'Calendar',
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
          elevation: 0,
          backgroundColor: Color(0x00FFFFFF),
        ),
        body: SfCalendar(
          cellBorderColor: Colors.black12,
          todayHighlightColor: Colors.orange,
          allowedViews: const [
            CalendarView.day,
            CalendarView.week,
            CalendarView.workWeek,
            CalendarView.month,
            CalendarView.timelineDay,
            CalendarView.timelineWeek,
            CalendarView.timelineWorkWeek,
            CalendarView.timelineMonth,
            CalendarView.schedule
          ],
          view: CalendarView.month,
          monthViewSettings: const MonthViewSettings(showAgenda: true),
          onTap: calendarTapped,
          dataSource: _getCalendarDataSource(),
        ));
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.appointment) {
      Appointment appointment = calendarTapDetails.appointments![0];
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => widget.userType == 'ADMINISTRATOR'
                ? Administrator_event_details(
                    docId: appointment.notes as String)
                : Student_Faculty_event_details(
                    docId: appointment.notes as String)),
      );
    }
  }

  String formatString(String input) {
    List<String> parts = input.split('-'); // Split the input string by hyphens
    List<String> reversedParts =
        parts.reversed.toList(); // Reverse the order of the parts
    return reversedParts.join(
        '-'); // Join the reversed parts with hyphens and return the result
  }

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];

    if (widget.events != null) {
      for (var event in widget.events) {
        if (event.data()['Status'] != 'REJECTED' &&
            event.data()['Status'] != 'WITHDRAWN') {
          appointments.add(Appointment(
            notes: event.id,
            startTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(
                '${formatString(event.data()['Date']) + ' ' + event.data()['Event Start Time']}:00'),
            endTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(
                '${formatString(event.data()['Date']) + ' ' + event.data()['Event End Time']}:00'),
            subject: event.data()['Event Name'],
            color: Colors.green,
          ));
        }
      }
    }
    // appointments.add(Appointment(
    //   startTime: DateTime.now(),
    //   endTime: DateTime.now().add(const Duration(hours: 2)),
    //   subject: 'Meeting',
    //   color: Colors.green,
    // ));
    // appointments.add(Appointment(
    //   startTime: DateTime.now().add(const Duration(hours: 3)),
    //   endTime: DateTime.now().add(const Duration(hours: 4)),
    //   subject: 'Planning',
    //   color: Colors.orange,
    // ));
    return _AppointmentDataSource(appointments);
  }
}

class SecondRoute extends StatelessWidget {
  Appointment? appointment;

  SecondRoute({super.key, this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Route"),
      ),
      body: Column(
        children: [
          const Divider(
            color: Colors.white,
          ),
          Center(
            child: Text(
              appointment!.subject,
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          Center(
            child: Text(DateFormat('MMMM yyyy,hh:mm a')
                .format(
                  appointment!.startTime,
                )
                .toString()),
          ),
          const Divider(
            color: Colors.white,
          ),
          Center(
            child: Text(DateFormat('MMMM yyyy,hh:mm a')
                .format(
                  appointment!.endTime,
                )
                .toString()),
          ),
        ],
      ),
    );
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
