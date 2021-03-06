﻿import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:yadonor/domain/appointment-item.dart';

class AppointmentsList {
  final List<Appointment> appointments;
  AppointmentsList({@required this.appointments});

  Appointment get nearestAppointment {
    if (appointments != null) {
      return appointments.firstWhere((entry) {
        return entry.day.isAfter(DateTime.now());
      }, orElse: () => null);
    } else
      return null;
  }

  List<Appointment> get futureAppointments {
    return appointments.where(
        (entry) {
          return entry.day.isAfter(DateTime.now());
        },
      ).toList();
  }

  List<Appointment> get pastAppointments {
    return appointments.where(
        (entry) {
          return entry.day.isBefore(DateTime.now());
        },
      ).toList();
  }

  List<Appointment> currentMonthAppointments(DateTime firstVisibleDate) {
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
}
