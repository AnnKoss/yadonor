import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:yadonor/models/appointment-item.dart';

enum FilterType { future, past, current } ///Chooses whether to show events of the current month, all the future or all the past ones.

///State provider for all child widgets in calendar_screen.dart
class CalendarScreenProvider with ChangeNotifier {
  List<Appointment> appointments;

  CalendarScreenProvider(this.appointments);

  DateTime firstVisibleDate = DateTime(
    /// The first date visible on the screen of current month. Used for changing displayed current month appointments in appointment_list_filtered.dart.
      DateTime.now().year,
      DateTime.now().month,
      1); 

  ///is the [selectedDay] in the future (true) or in the past
  bool isFutureDate = true; 

  List<Appointment> getCurrentMonthAppointments() {
    /// Appointments of current month.
    return appointments.where(
      (entry) {
        String selectedAppointmentMonth = DateFormat.yM().format(entry.day);
        int year = firstVisibleDate.add(Duration(days: 15)).year;
        int month = firstVisibleDate.add(Duration(days: 15)).month;
        String currentMonth = DateFormat.yM().format(DateTime(year, month));

        return selectedAppointmentMonth == currentMonth;
      },
    ).toList();
  } 

  List<Appointment> getFutureAppointments() {
    ///Future appointments, counted since today.
    return appointments.where(
      (entry) {
        return entry.day.isAfter(DateTime.now().subtract(Duration(days: 1)));
      },
    ).toList();
  }

  List<Appointment> getPastAppointments() {
    ///Past appointments.
    return appointments.where(
      (entry) {
        return entry.day.isBefore(DateTime.now());
      },
    ).toList();
  }

  /// Day selected on the calendar screen
  DateTime selectedDay; 

  void selectDay(DateTime day, List appointments) {
    ///A handler for [onDaySelected] property of Calendar widget.
    selectedDay = day;
    selectedDayCheck(day);
    print('day selected');

    notifyListeners();
  }

  void changeVisibleDates(DateTime from) {
    ///Changes displayed current month appointments in appointment_list_filtered.dart.
    firstVisibleDate = from;
    
    notifyListeners();
  }

  void selectedDayCheck(DateTime day) {
    ///Checks if [selectedDay] is in the past or in the future.
    if (day.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
      isFutureDate = true;
    } else {
      isFutureDate = false;
    }
    notifyListeners();
  }

  List<Appointment> displayedAppointments;

  void displayFilteredAppointments(FilterType filter) {
    ///Displays list of future, past or current month [Appointment] in appointment_list_filtered.dart according to [FilterType].
    if (filter == FilterType.current) {
      displayedAppointments = appointments.where(
        (entry) {
          var selectedAppointmentMonth = DateFormat.yM().format(entry.day);

          int year = firstVisibleDate.add(Duration(days: 15)).year;
          int month = firstVisibleDate.add(Duration(days: 15)).month;
          var currentMonth = DateFormat.yM().format(DateTime(year, month));
          return selectedAppointmentMonth == currentMonth;
        },
      ).toList();
    } else if (filter == FilterType.future) {
      displayedAppointments = appointments.where(
        (entry) {
          return entry.day.isAfter(DateTime.now().subtract(Duration(days: 1)));
        },
      ).toList();
    } else if (filter == FilterType.past) {
      displayedAppointments = appointments.where(
        (entry) {
          return entry.day.isBefore(DateTime.now());
        },
      ).toList();
    } else {
      displayedAppointments = appointments.where(
        (entry) {
          var selectedAppointmentMonth = DateFormat.yM().format(entry.day);

          int year = firstVisibleDate.add(Duration(days: 15)).year;
          int month = firstVisibleDate.add(Duration(days: 15)).month;
          var currentMonth = DateFormat.yM().format(DateTime(year, month));
          return selectedAppointmentMonth == currentMonth;
        },
      ).toList();
    }

    notifyListeners();
  }
}
