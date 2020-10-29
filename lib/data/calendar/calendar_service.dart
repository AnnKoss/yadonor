import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:yadonor/data/providers/calendar_appointments_provider.dart';
import 'package:yadonor/domain/appointment-item.dart';

class CalendarService {
  // List<Appointment> _appointments = [];

  Future<Appointment> addAppointment(DateTime selectedDay) async {
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
    } catch (error) {
      print(error);
      throw error;
    }

    return Appointment(selectedDay, 'Донорство крови');
  }

  Future<void> removeAppointment(Appointment selectedAppointment) async {
    ///Removes selected appointment from the server and the [_appointments] list.
    final String appointmentDate =
        DateFormat('y-M-d').format(selectedAppointment.day);
    final String userId = FirebaseAuth.instance.currentUser.uid;
    final String url =
        'https://yadonor-app.firebaseio.com/$userId/$appointmentDate.json';

    try {
      http.delete(url);
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
