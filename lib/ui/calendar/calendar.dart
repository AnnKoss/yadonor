import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:yadonor/data/appointment-item.dart';

class Calendar extends StatefulWidget {
  final void Function(DateTime, List<dynamic>) onDaySelected;
  final OnVisibleDaysChanged onVisibleDaysChanged;
  final List<Appointment> appointments;
  Calendar({this.onDaySelected, this.onVisibleDaysChanged, this.appointments});

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
    final Map<DateTime, List> calendarAppointments = Map.fromIterable(
        widget.appointments,
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
      onVisibleDaysChanged: widget.onVisibleDaysChanged,
    );
  }
}
