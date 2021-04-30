import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:yadonor/domain/appointment-item.dart';

class AppointmentsStorage {
  List<Appointment> appointments = [];
}

///Has CRUD methods for appointments.
class AppointmentsRepository {
  final AppointmentsStorage _storage;

  AppointmentsRepository(this._storage);

  int Function(Appointment, Appointment) appointmentComparator = (a, b) {
    return a.day.compareTo(b.day);
  };

  ///Loads appointments from the server and places them to the [_storage].
  Future<List<Appointment>> getAppointments() async {
    final String userId = FirebaseAuth.instance.currentUser.uid;

    if (_storage.appointments.isNotEmpty) {
      return _storage.appointments;
    } else {
      final List<Appointment> loadedAppointments = [];
      final String url = 'https://yadonor-app.firebaseio.com/$userId.json';
      try {
        final response = await http.get(url);
        if (json.decode(response.body) != null) {
          final extractedData = json.decode(
            response.body,
          ) as Map<String, dynamic>;
          extractedData.forEach(
            (key, value) {
              loadedAppointments.add(
                Appointment(
                  DateTime.parse(
                    value['day'],
                  ),
                  value['appointment'],
                ),
              );
            },
          );
        }
        loadedAppointments.sort(appointmentComparator);
        _storage.appointments.clear();
        _storage.appointments.addAll(loadedAppointments);
      } catch (error) {
        rethrow;
      }
      return _storage.appointments.toList();
    }
  }

  ///Adds appointment on [selectedDay] to the server and [_storage].
  Future<List<Appointment>> addAppointment(selectedDay) async {
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
      Appointment addedAppointment = Appointment(
        selectedDay,
        'Донорство крови',
      );
      _storage.appointments.add(addedAppointment);
    } catch (error) {
      print(error);
      throw error;
    }
    return _storage.appointments..sort(appointmentComparator);
  }

  ///Removes selected appointment from the server and [_storage].
  Future<List<Appointment>> removeAppointment(DateTime day) async {
    final String appointmentDate = DateFormat('y-M-d').format(day);
    final String userId = FirebaseAuth.instance.currentUser.uid;
    final String url =
        'https://yadonor-app.firebaseio.com/$userId/$appointmentDate.json';

    try {
      http.delete(url);
      final Appointment removedAppointment = _storage.appointments.firstWhere(
        (appointment) => appointment.day == appointment.day,
      );
      print('removedAppointment: ${removedAppointment.toString()}');
      if (removedAppointment != null) {
        _storage.appointments.removeWhere(
          (appointment) => appointment == removedAppointment,
        );
        return _storage.appointments..sort(appointmentComparator);
      }
    } catch (error) {
      print(error);
      throw error;
    }
    return _storage.appointments..sort(appointmentComparator);
  }
}
