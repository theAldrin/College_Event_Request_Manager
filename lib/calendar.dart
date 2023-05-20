import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppointmentDetails(),
    );
  }
}

class AppointmentDetails extends StatefulWidget {
  const AppointmentDetails({super.key});

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
          title: _title(),
          backgroundColor: Colors.white,
        ),
        body: SfCalendar(
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
            builder: (context) => SecondRoute(appointment: appointment)),
      );
    }
  }

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 2)),
      subject: 'Meeting',
      color: Colors.green,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 3)),
      endTime: DateTime.now().add(const Duration(hours: 4)),
      subject: 'Planning',
      color: Colors.orange,
    ));
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
