// import 'package:flutter/material.dart';

// class CalendarScreenProvider with ChangeNotifier {
//   DateTime firstVisibleDate = DateTime(
//       DateTime.now().year,
//       DateTime.now().month,
//       1); // The first date visible on the screen of current month

//   List<Appointment> getCurrentMonthEvents() {
//     return events.where(
//       (entry) {
//         var selectedEventMonth = DateFormat.yM().format(entry.day);

//         int year = firstVisibleDate.add(Duration(days: 15)).year;
//         int month = firstVisibleDate.add(Duration(days: 15)).month;
//         var currentMonth = DateFormat.yM().format(DateTime(year, month));
//         return selectedEventMonth == currentMonth;
//       },
//     ).toList();
//   } // Events of current month

//   void changeVisibleDates(DateTime from) {
//     firstVisibleDate = from;
//     notifyListeners();
//   }
// }