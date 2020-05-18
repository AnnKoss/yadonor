import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

import '../providers/calendar_provider.dart';
import '../widgets/button.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController;
  var thisMonthEvents = {};

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
    final calendarData = Provider.of<CalendarProvider>(context);
    final calendarEvents = calendarData.events;

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
      onDaySelected: Provider.of<CalendarProvider>(context).onDaySelected,
      events: calendarEvents,
      rowHeight: 50,
      onVisibleDaysChanged: (from, to, format) {
        Provider.of<CalendarProvider>(context, listen: false)
            .changeVisibleDates(from);
        Provider.of<CalendarProvider>(context, listen: false)
            .updateCurrentMonthEvents();
        // print(from);
      },
    );
  }
}
