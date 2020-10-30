import 'dart:convert';

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

  Future<List<Appointment>> getAppointments() async {
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
        });
      }

      _storage.appointments.clear();
      _storage.appointments.addAll(loadedAppointments);

      return _storage.appointments;
    } catch (error) {
      if (_storage.appointments.isEmpty) {
        rethrow;
      }
      return _storage.appointments;
    }
  }

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