import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:yadonor/domain/appointment-item.dart';

// enum FilterType { future, past, current }

///App-wide state provider for future and past donor appointments.
class CalendarAppointmentRepository  {
  CalendarAppointmentRepository() {
    ///Loads [_appointments] from the server when the consctructor is called and manages the circularProfressInficator while not finished.
    isFetchAppointmentsLoading = true;
    fetchAppointments().then((_) => isFetchAppointmentsLoading = false);
  }

  /// All appointments.
  List<Appointment> _appointments = []; 

  List<Appointment> get appointments {
    return _appointments;
  }

  bool isFetchAppointmentsLoading = false;

  Future<void> fetchAppointments() async {
    ///Loads [_appointments] from the user folder on the server and sorts them by the ['day] value.
    final String userId = FirebaseAuth.instance.currentUser.uid;
    print(userId);
    print('fetchAppointments');
    final String url = 'https://yadonor-app.firebaseio.com/$userId.json';
    try {
      final response = await http.get(url);
      final List<Appointment> loadedAppointments = [];
      if (json.decode(response.body) != null) {
        print('income json:');
        print(json.decode(response.body));
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        extractedData.forEach((key, value) {
          loadedAppointments.add(
            Appointment(
              DateTime.parse(value['day']),
              value['appointment'],
            ),
          );
          _appointments = loadedAppointments;
          sortAppointments();

        });
      } else {
        _appointments = [];
        print('_appointments');

      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> addAppointment(DateTime selectedDay) async {
    ///Puts the newly added appointment on the user folder on the server and adds it to the [_appointments] list.
    
    //validation on the number of days passed from the previous appointment

    // if (_appointments.isNotEmpty &&
    //       (_appointments.keys
    //               .toList()[_appointments.keys.length - 1]
    //               .add(Duration(days: 6)) //days - 60
    //               .isAfter(_selectedDay) &&
    //           _appointments.keys
    //               .toList()[_appointments.keys.length - 1]
    //               .subtract(Duration(days: 6)) //days - 60
    //               .isBefore(_selectedDay))) {
    //     print('Oopse');
    //   } else
    // DateTime selectedDay = Provider.of<CalendarScreenProvider>(context).selectedDay;

    if (selectedDay != null) {
      final String userId = FirebaseAuth.instance.currentUser.uid;
      final String appointmentDate = DateFormat('y-M-d').format(selectedDay);
      final String url = 'https://yadonor-app.firebaseio.com/$userId/$appointmentDate.json';

      await http
          .put(
        url,
        body: json.encode(
          {
            'day': selectedDay.toString(),
            'appointment': 'Донорство крови',
          },
        ),
      )
          .catchError((error) {
        print(error);
        throw error;
      }).then((_) {
        _appointments.add(Appointment(selectedDay, 'Донорство крови'));

        sortAppointments();

        print(
          _appointments
              .map((appointment) =>
                  appointment.day.toString() +
                  ': ' +
                  appointment.appointment.toString() +
                  ';')
              .toList(),
        );

      });
    }
  }

  Future<void> removeAppointment(day) async {
    ///Removes selected appointment from the server and the [_appointments] list.
    final Appointment selectedAppointment =
        _appointments.firstWhere((appointment) => appointment.day == day);
    final String appointmentDate =
        DateFormat('y-M-d').format(selectedAppointment.day);
    final String userId = FirebaseAuth.instance.currentUser.uid;
    final String url = 'https://yadonor-app.firebaseio.com/$userId/$appointmentDate.json';

    await http.delete(url).catchError((error) {
      print(error);
      throw error;
    }).then((_) {
      _appointments.remove(selectedAppointment);

    });
  }

  void sortAppointments() {
    _appointments = _appointments
      ..sort((a, b) {
        return a.day.compareTo(b.day);
      });
  }

  // bool isAvaliableDate = true; //is the date in the future (true) or in the past

  // void selectDay(DateTime day, List appointments) {
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
    ///Returns the first [Appointment] since today.
    return appointments.firstWhere((entry) {
      return entry.day.isAfter(DateTime.now());
    }, orElse: () => null);
  }
}
