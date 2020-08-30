import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import './calendar_events_provider.dart';

//State provider for all child widgets in calendar_screen.dart
class CalendarScreenProvider with ChangeNotifier {
  List<Appointment> events;

  CalendarScreenProvider(this.events);

  DateTime firstVisibleDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      1); // The first date visible on the screen of current month. Used for changing displayed current month events in event_list_filtered.dart

  bool isAvaliableDate = true; //is the date in the future (true) or in the past

  List<Appointment> getCurrentMonthEvents() {
    // List<Appointment> events = Provider.of<CalendarEventsProvider>(context).events;
    return events.where(
      (entry) {
        var selectedEventMonth = DateFormat.yM().format(entry.day);

        int year = firstVisibleDate.add(Duration(days: 15)).year;
        int month = firstVisibleDate.add(Duration(days: 15)).month;
        var currentMonth = DateFormat.yM().format(DateTime(year, month));
        return selectedEventMonth == currentMonth;
      },
    ).toList();
  } // Events of current month

  List<Appointment> getFutureEvents() {
    // List<Appointment> events = Provider.of<CalendarEventsProvider>(context).events;
    return events.where(
      (entry) {
        return entry.day.isAfter(DateTime.now().subtract(Duration(days: 1)));
      },
    ).toList();
  }

  List<Appointment> getPastEvents() {
    // List<Appointment> events = Provider.of<CalendarEventsProvider>(context).events;
    return events.where(
      (entry) {
        return entry.day.isBefore(DateTime.now());
      },
    ).toList();
  }

  DateTime selectedDay; // Day selected on the calendar screen

  void selectDay(DateTime day, List events) {
    selectedDay = day;
    selectedDayCheck(day);
    print('day selected');

    notifyListeners();
  }

  void changeVisibleDates(DateTime from) {
    firstVisibleDate = from;
    notifyListeners();
  }

  void selectedDayCheck(DateTime day) {
    if (day.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
      // print('Not able to pick date in the past');
      isAvaliableDate = true;
    } else {
      // print('Choose the date!');

      isAvaliableDate = false;
    }
    notifyListeners();
  }

  List<Appointment> displayedEvents;

  void displayFilteredEvents(FilterType filter) {
    // List<Appointment> events = Provider.of<CalendarEventsProvider>(context).events;
    if (filter == FilterType.current) {
      displayedEvents = events.where(
        (entry) {
          var selectedEventMonth = DateFormat.yM().format(entry.day);

          int year = firstVisibleDate.add(Duration(days: 15)).year;
          int month = firstVisibleDate.add(Duration(days: 15)).month;
          var currentMonth = DateFormat.yM().format(DateTime(year, month));
          return selectedEventMonth == currentMonth;
        },
      ).toList();
    } else if (filter == FilterType.future) {
      displayedEvents = events.where(
        (entry) {
          return entry.day.isAfter(DateTime.now().subtract(Duration(days: 1)));
        },
      ).toList();
    } else if (filter == FilterType.past) {
      displayedEvents = events.where(
        (entry) {
          return entry.day.isBefore(DateTime.now());
        },
      ).toList();
    } else {
      displayedEvents = events.where(
        (entry) {
          var selectedEventMonth = DateFormat.yM().format(entry.day);

          int year = firstVisibleDate.add(Duration(days: 15)).year;
          int month = firstVisibleDate.add(Duration(days: 15)).month;
          var currentMonth = DateFormat.yM().format(DateTime(year, month));
          return selectedEventMonth == currentMonth;
        },
      ).toList();
    }

    notifyListeners();
  }
}
