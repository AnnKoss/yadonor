import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:collection';

enum FilterType { future, past, calendar }

class CalendarProvider with ChangeNotifier {
  Map<DateTime, List> _events = {};

  Map<DateTime, List> get events {
    return {..._events};
  }

  DateTime selectedDay;

  DateTime firstVisibleDate =
      DateTime(DateTime.now().year, DateTime.now().month, 1);

  List currentMonthEvents = [];
  String currentMonthEventsText = '';

  List displayedEvents = [];

  FilterType eventsFilter = FilterType.calendar;

  bool isCorrectDate = true;

  void addEvent() {
    // if (_events.isNotEmpty &&
    //       (_events.keys
    //               .toList()[_events.keys.length - 1]
    //               .add(Duration(days: 6)) //days - 60
    //               .isAfter(_selectedDay) &&
    //           _events.keys
    //               .toList()[_events.keys.length - 1]
    //               .subtract(Duration(days: 6)) //days - 60
    //               .isBefore(_selectedDay))) {
    //     print('Oopse'); //damn this longy-long condition. Is it legal?
    //   } else
    if (selectedDay != null) {
      _events[selectedDay] = ['Донорство крови'];

      var keysList = _events.keys.toList();
      var sortedKeys = keysList..sort((k1, k2) => k1.compareTo(k2));
      _events =
          Map.fromIterable(sortedKeys, key: (k) => k, value: (k) => _events[k]);

      updateCurrentMonthEvents();
      print(_events);

      notifyListeners();
    }
  }

  void removeEvent(day) {
    _events.removeWhere((key, value) => key == day);
    print(_events);
    notifyListeners();
  }

  void onDaySelected(DateTime day, List events) {
    selectedDay = day;
    if (day.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
      // print('Not able to pick date in the past');
      isCorrectDate = true;
    } else {
      // print('Choose the date!');

      isCorrectDate = false;
    }
    notifyListeners();
  }

  void changeVisibleDates(DateTime from) {
    firstVisibleDate = from;
    notifyListeners();
  }

  void updateCurrentMonthEvents() {
    currentMonthEvents = events.entries.where(
      (entry) {
        var selectedEventMonth = DateFormat.yM().format(entry.key);

        int year = firstVisibleDate.add(Duration(days: 15)).year;
        int month = firstVisibleDate.add(Duration(days: 15)).month;
        var currentMonth = DateFormat.yM().format(DateTime(year, month));
        return selectedEventMonth == currentMonth;
      },
    ).toList();
    // print(currentMonthEvents);
    currentMonthEvents.forEach((eventEntry) => eventEntry.value[0].toString());
    notifyListeners();
  }

  void selectFilter(FilterType result) {
    eventsFilter = result;
    // print(eventsFilter);
    if (eventsFilter == FilterType.calendar) {
      changeVisibleDates(
          DateTime(DateTime.now().year, DateTime.now().month, 1));
      updateCurrentMonthEvents();
    }
    notifyListeners();
  }
}
