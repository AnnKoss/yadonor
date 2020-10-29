// import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yadonor/data/calendar/calendar_service.dart';
import 'package:yadonor/domain/appointment-item.dart';
import 'package:yadonor/ui/calendar/appointments_bloc.dart';

abstract class CalendarEvent {}

class AddAppointmentEvent extends CalendarEvent {
  DateTime selectedDay;

  AddAppointmentEvent(this.selectedDay);
}

class RemoveAppointmentEvent extends CalendarEvent {
  DateTime day;

  RemoveAppointmentEvent(this.day);
}

class FetchAppointmentsEvent extends CalendarEvent {}

class CalendarState {}

class CalendarLoadingState extends CalendarState {}

class CalendarErrorState extends CalendarState {}

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CalendarService _service = CalendarService();

  List<Appointment> appointments = [];

  CalendarBloc(CalendarState initialState) : super(initialState);

  @override
  Stream<CalendarState> mapEventToState(CalendarEvent event) {
    if (event is AddAppointmentEvent) {
      return _performAddAppointment(event);
    } else {
      throw UnimplementedError();
    }
  }

  Stream<CalendarState> _performAddAppointment(
      AddAppointmentEvent event) async* {
    yield CalendarLoadingState();

    if (event.selectedDay != null) {
      Appointment appointment =
          await _service.addAppointment(event.selectedDay);
      appointments.add(appointment);

      sortAppointments();

      print(
        appointments
            .map((appointment) =>
                appointment.day.toString() +
                ': ' +
                appointment.appointment.toString() +
                ';')
            .toList(),
      );
    } else {
      yield CalendarErrorState();
    }
  }

  Stream<CalendarState> _performRemoveAppointment(
      RemoveAppointmentEvent event) async* {
    yield CalendarLoadingState();
    
    final Appointment selectedAppointment =
        appointments.firstWhere((appointment) => appointment.day == event.day);

    if (selectedAppointment != null) {
      await _service.removeAppointment(selectedAppointment);
    appointments.remove(selectedAppointment);
    } else  {
      yield CalendarErrorState();
    }
  }

  void sortAppointments() {
    appointments = appointments
      ..sort((a, b) {
        return a.day.compareTo(b.day);
      });
  }
}
