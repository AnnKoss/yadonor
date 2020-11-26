﻿import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:yadonor/domain/appointment-item.dart';

class AppointmentsStorage {
  List<Appointment> appointments = [];
}

/// Repository has CRUD methods
class AppointmentsRepository {
  final AppointmentsStorage _storage;

  AppointmentsRepository(this._storage);

  DateTime selectedDay = DateTime.now();

  DateTime firstVisibleDate = DateTime(

      /// The first date visible on the screen of current month. Used for changing displayed current month appointments in appointment_list_filtered.dart.
      DateTime.now().year,
      DateTime.now().month,
      1);

  Future<void> selectDay(DateTime day, List<Appointment> appointments) async {
    ///A handler for [onDaySelected] property of Calendar widget.
    // DateTime selectedDay;
    if (day != null) {
      selectedDay = day;
    }
    // return selectedDay;
  }

  Future<void> changeVisibleDates(DateTime from) async {
    ///Changes displayed current month appointments in appointment_list_filtered.dart.
    firstVisibleDate = from;

    getCurrentMonthAppointments();
  }

  List<Appointment> getCurrentMonthAppointments() {
    /// Appointments of current month.
    return _storage.appointments.where(
      (entry) {
        String selectedAppointmentMonth = DateFormat.yM().format(entry.day);
        int year = firstVisibleDate.add(Duration(days: 15)).year;
        int month = firstVisibleDate.add(Duration(days: 15)).month;
        String currentMonth = DateFormat.yM().format(DateTime(year, month));

        return selectedAppointmentMonth == currentMonth;
      },
    ).toList();
  }

  Future<List<Appointment>> getAppointments() async {
    final String userId = FirebaseAuth.instance.currentUser.uid;
    print(userId);
    print('fetchAppointments');

    // if (_storage.appointments.isNotEmpty) {
    //   return _storage.appointments;
    // }
    final List<Appointment> loadedAppointments = [];

    final String url = 'https://yadonor-app.firebaseio.com/$userId.json';
    try {
      final response = await http.get(url);
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
        });
        print(extractedData.length.toString() + ' - number of loaded appointments');
      }

      print('appointments_servise getAppointments: ' + loadedAppointments.toString());
      // _storage.appointments.clear();
      // _storage.appointments.addAll(loadedAppointments);

      // sortAppointments();

      // return _storage.appointments;

    } catch (error) {
      // if (_storage.appointments.isEmpty) {
      //   rethrow;
      // }
      rethrow;
    }
    return loadedAppointments;
    // return _storage.appointments;
  }

  Future<void> addAppointment(selectedDay) async {
    final String userId = FirebaseAuth.instance.currentUser.uid;
    final String appointmentDate = DateFormat('y-M-d').format(selectedDay);
    final String url =
        'https://yadonor-app.firebaseio.com/$userId/$appointmentDate.json';

    try {
      http.put(
        url,
        body: json.encode(
          {
            'day': selectedDay.toString(),
            'appointment': 'Донорство крови',
          },
        ),
      );
      // _storage.appointments.add(Appointment(
      //   selectedDay,
      //   'Донорство крови',
      // ));
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> removeAppointment(DateTime day) async {
    ///Removes selected appointment from the server and the [_appointments] list.
    final String appointmentDate = DateFormat('y-M-d').format(day);
    final String userId = FirebaseAuth.instance.currentUser.uid;
    final String url =
        'https://yadonor-app.firebaseio.com/$userId/$appointmentDate.json';

    try {
      http.delete(url);

      // final Appointment selectedAppointment = _storage.appointments
      //     .firstWhere((appointment) => appointment.day == appointment.day);

      // if (selectedAppointment != null) {
      //   _storage.appointments
      //       .removeWhere((appointment) => appointment == selectedAppointment);
      // }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Appointment get getNearestAppointment {
    ///Returns the first [Appointment] since today.

    return _storage.appointments.firstWhere((entry) {
      return entry.day.isAfter(DateTime.now());
    }, orElse: () => null);
  }

  void sortAppointments() {
    _storage.appointments = _storage.appointments
      ..sort((a, b) {
        return a.day.compareTo(b.day);
      });
  }
}
