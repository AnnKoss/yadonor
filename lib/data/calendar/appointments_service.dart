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
  DateTime selectedDay = DateTime.now();

  DateTime firstVisibleDate = DateTime(

      /// The first date visible on the screen of current month. Used for changing displayed current month appointments in appointment_list_filtered.dart.
      DateTime.now().year,
      DateTime.now().month,
      1);

  Future<List<Appointment>> getAppointments() async {
    final String userId = FirebaseAuth.instance.currentUser.uid;
    print(userId);
    print('fetchAppointments');

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
        print(extractedData.length.toString() +
            ' - number of loaded appointments');
      }

      print('appointments_servise getAppointments: ' +
          loadedAppointments.toString());
     
    } catch (error) {
      
      rethrow;
    }
    return loadedAppointments;
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

    } catch (error) {
      print(error);
      throw error;
    }
  }

}
