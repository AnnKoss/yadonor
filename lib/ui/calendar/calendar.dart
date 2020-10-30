import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:yadonor/data/providers/calendar_appointments_provider.dart';
import 'package:yadonor/data/providers/calendar_screen_provider.dart';

class Calendar extends StatefulWidget {
  final Function onDaySelected;

  const Calendar({Key key, @required this.onDaySelected}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController;
  var thisMonthAppointments = {};

  bool isCorrectDate = true;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();

    initializeDateFormatting();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final calendarAppointmentsData = Provider.of<CalendarAppointmentRepository>(context);
    final Map<DateTime, List> calendarAppointments = Map.fromIterable(
        calendarAppointmentsData.appointments,
        key: (appointment) => appointment.day,
        value: (appointment) => [appointment.appointment]);
    print(calendarAppointments);

    return TableCalendar(
      calendarController: _calendarController,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        centerHeaderTitle: true,
        headerPadding: EdgeInsets.only(bottom: 8),
      ),
      calendarStyle: CalendarStyle(
        selectedColor: Theme.of(context).primaryColor,
        todayColor: Theme.of(context).primaryColorLight,
        markersColor: Theme.of(context).accentColor,
      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
      locale: 'ru_Ru',
      onDaySelected: widget.onDaySelected,
      events: calendarAppointments,
      rowHeight: 40,
      onVisibleDaysChanged: (from, to, format) {
        Provider.of<CalendarScreenProvider>(context, listen: false)
            .changeVisibleDates(from);
        Provider.of<CalendarScreenProvider>(context, listen: false)
            .getCurrentMonthAppointments();
        // print(from);
      },
    );
  }
}
