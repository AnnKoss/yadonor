import 'package:intl/intl.dart';

import 'package:yadonor/domain/appointment-item.dart';
import 'package:yadonor/ui/calendar_screen/appointments_bloc.dart';

class Appointments {
  final List<Appointment> appointmentsList;
  final DateTime firstVisibleDate;
  final FilterType filter;
  Appointments({
    this.appointmentsList,
    this.firstVisibleDate,
    this.filter,
  });

  Appointment get nearestAppointment {
    // print('get nearestAppointment appointments: ' + appointments.toString());
    if (appointmentsList != null) {
      return appointmentsList.firstWhere((entry) {
        return entry.day.isAfter(DateTime.now());
      }, orElse: () => null);
    } else
      return null;
  }

  FilteredAppointments get filteredAppointments {
    switch (filter) {
      case FilterType.future:
        return FilteredAppointments(
          futureAppointments,
          'Предстоящие донации:',
        );
        break;
      case FilterType.past:
        return FilteredAppointments(
          pastAppointments,
          'Прошедшие донации:',
        );
        ;
        break;
      case FilterType.current:
        return FilteredAppointments(
          currentMonthAppointments(firstVisibleDate),
          'Донации в этом месяце:',
        );
        break;
      default:
        return FilteredAppointments(
          currentMonthAppointments(firstVisibleDate),
          'Донации в этом месяце:',
        );
        break;
    }
  }

  List<Appointment> get futureAppointments {
    return appointmentsList.where(
      (entry) {
        return entry.day.isAfter(DateTime.now());
      },
    ).toList();
  }

  List<Appointment> get pastAppointments {
    return appointmentsList.where(
      (entry) {
        return entry.day.isBefore(DateTime.now());
      },
    ).toList();
  }

  List<Appointment> currentMonthAppointments(DateTime firstVisibleDate) {
    return appointmentsList.where(
      (entry) {
        String selectedAppointmentMonth = DateFormat.yM().format(
          entry.day,
        );
        int year = firstVisibleDate
            .add(
              Duration(days: 15),
            )
            .year;
        int month = firstVisibleDate
            .add(
              Duration(days: 15),
            )
            .month;
        String currentMonth = DateFormat.yM().format(
          DateTime(
            year,
            month,
          ),
        );
        return selectedAppointmentMonth == currentMonth;
      },
    ).toList();
  }
}

class FilteredAppointments {
  final List<Appointment> appointments;
  final String appointmentsText;
  FilteredAppointments(
    this.appointments,
    this.appointmentsText,
  );
}
