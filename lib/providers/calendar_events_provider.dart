import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// import 'dart:collection';

// import 'package:provider/provider.dart';

enum FilterType { future, past, current }

class Appointment {
  final DateTime day;
  final String event;

  Appointment(this.day, this.event);
}

//State provider for future and past appointments
class CalendarEventsProvider with ChangeNotifier {
  List<Appointment> _events = []; // All appointments

  List<Appointment> get events {
    return _events;
  }

  Future<void> addEvent(DateTime selectedDay) async {
    // if (_events.isNotEmpty &&
    //       (_events.keys
    //               .toList()[_events.keys.length - 1]
    //               .add(Duration(days: 6)) //days - 60
    //               .isAfter(_selectedDay) &&
    //           _events.keys
    //               .toList()[_events.keys.length - 1]
    //               .subtract(Duration(days: 6)) //days - 60
    //               .isBefore(_selectedDay))) {
    //     print('Oopse');
    //   } else
    // DateTime selectedDay = Provider.of<CalendarScreenProvider>(context).selectedDay;

    if (selectedDay != null) {
      final String eventDate = DateFormat('y-M-d').format(selectedDay);
      final url = 'https://yadonor-app.firebaseio.com/events/$eventDate.json';
      try {
        http.put(
          url,
          body: json.encode(
            {
              'day': selectedDay.toString(),
              'event': 'Донорство крови',
              // 'place': 'place',
            },
          ),
        );
        _events.add(Appointment(selectedDay, 'Донорство крови'));

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
      } catch (error) {
        print(error);
        throw error;
      }
    }
  }

  Future<void> removeEvent(day) async {
    Appointment selectedAppointment =
        _events.firstWhere((appointment) => appointment.day == day);
    final String eventDate = DateFormat('y-M-d').format(selectedAppointment.day);
    final url = 'https://yadonor-app.firebaseio.com/events/$eventDate.json';
    try {
      http.delete(url);

      _events.remove(selectedAppointment);

      print(_events);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  // bool isAvaliableDate = true; //is the date in the future (true) or in the past

  // void selectDay(DateTime day, List events) {
  //   selectedDay = day;
  //   if (day.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
  //     // print('Not able to pick date in the past');
  //     isAvaliableDate = true;
  //   } else {
  //     // print('Choose the date!');

  //     isAvaliableDate = false;
  //   }
  //   notifyListeners();
  // }

  Appointment getNearestAppointment() {
    return events.firstWhere((entry) {
      return entry.day.isAfter(DateTime.now().subtract(Duration(days: 1)));
    }, orElse: () => null);
  }

  // void changeVisibleDates(DateTime from) {
  //   firstVisibleDate = from;
  //   notifyListeners();
  // }
}
