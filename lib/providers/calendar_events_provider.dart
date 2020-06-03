import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:collection';

enum FilterType { future, past, current }

class Appointment {
  final DateTime day;
  final List<String> event;

  Appointment(this.day, this.event);
}

//State provider for future and past appointments
class CalendarEventsProvider with ChangeNotifier {
  List<Appointment> _events = []; // Day -> List<appointment>. All appointments

  List<Appointment> get events {
    return [..._events];
  }

  DateTime selectedDay; // Day selected on the calendar screen

  DateTime firstVisibleDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      1); // The first date visible on the screen of current month

  List<Appointment> getCurrentMonthEvents() {
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

  List<Appointment> get futureEvents {
    return events.where(
      (entry) {
        return entry.day.isAfter(DateTime.now().subtract(Duration(days: 1)));
      },
    ).toList();
  }

  List<Appointment> get pastEvents {
    return events.where(
      (entry) {
        return entry.day.isBefore(DateTime.now());
      },
    ).toList();
  }

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
      _events.add(Appointment(selectedDay, ['Донорство крови']));

      _events = _events
        ..sort((a, b) {
          return a.day.compareTo(b.day);
        });

      print(
        _events
            .map((appointment) =>
                appointment.day.toString() +
                ': ' +
                appointment.event.toString() +
                ';')
            .toList(),
      );

      notifyListeners();
    }
  }

  void removeEvent(day) {
    _events.removeWhere((appointment) => appointment.day == day);

    print(_events);
    notifyListeners();
  }

  bool isAvaliableDate = true; //is the date in the future (true) or in the past

  void onDaySelected(DateTime day, List events) {
    selectedDay = day;
    if (day.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
      // print('Not able to pick date in the past');
      isAvaliableDate = true;
    } else {
      // print('Choose the date!');

      isAvaliableDate = false;
    }
    notifyListeners();
  }

  void changeVisibleDates(DateTime from) {
    firstVisibleDate = from;
    notifyListeners();
  }
}
