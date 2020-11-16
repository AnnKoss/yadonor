// import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:yadonor/data/calendar/appointments_service.dart';
import 'package:yadonor/data/calendar/calendar_service.dart';
import 'package:yadonor/domain/appointment-item.dart';
import 'package:yadonor/ui/calendar/appointments_bloc.dart';

abstract class CalendarEvent {}

class AddAppointmentEvent extends CalendarEvent {
  // DateTime selectedDay;

  // AddAppointmentEvent(this.selectedDay);
}

class RemoveAppointmentEvent extends CalendarEvent {
  DateTime day;

  RemoveAppointmentEvent(this.day);
}

class GetAppointmentsEvent extends CalendarEvent {}

class SelectDayEvent extends CalendarEvent {
  DateTime day;
  List<Appointment> appointments;

  SelectDayEvent(this.day, this.appointments);
}

class ChangeVisibleDatesEvent extends CalendarEvent {
  DateTime from;
  DateTime to;
  CalendarFormat format;

  ChangeVisibleDatesEvent(this.from, this.to, this.format);
}

class GetNearestAppointmentEvent extends CalendarEvent {}

class CalendarState {}

class CalendarLoadingState extends CalendarState {}

class CalendarErrorState extends CalendarState {}

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final AppointmentsRepository _service;

  // List<Appointment> appointments = [];

  CalendarBloc(CalendarState initialState, this._service) : super(initialState);

  @override
  Stream<CalendarState> mapEventToState(CalendarEvent event) {
    if (event is AddAppointmentEvent) {
      return _performAddAppointment(event);
    } else if (event is RemoveAppointmentEvent) {
      return _performRemoveAppointment(event);
    } else if (event is GetAppointmentsEvent) {
      return _performGetAppointments(event);
    } else if (event is SelectDayEvent) {
      return _performSelectDay(event);
    } else if (event is ChangeVisibleDatesEvent) {
      return _performChangeVisibleDates(event);
    } else if (event is GetNearestAppointmentEvent) {
      return _performGetNearestAppointment(event);
    }
     else {
      throw UnimplementedError();
    }
  }

  Stream<CalendarState> _performAddAppointment(
      AddAppointmentEvent event) async* {
    yield CalendarLoadingState();

    await _service.addAppointment();
  }

  Stream<CalendarState> _performRemoveAppointment(
      RemoveAppointmentEvent event) async* {
    yield CalendarLoadingState();

    await _service.removeAppointment(event.day);
  }

  Stream<CalendarState> _performGetAppointments(GetAppointmentsEvent event) async* {
    yield CalendarLoadingState();

    await _service.getAppointments();
  }

  Stream<CalendarState> _performSelectDay(SelectDayEvent event) async* {
    yield CalendarLoadingState();
    if (event.day != null) {
      await _service.selectDay(event.day, event.appointments);
    } else {
      yield CalendarErrorState();
    }
  }

  Stream<CalendarState> _performGetNearestAppointment(GetNearestAppointmentEvent event) async* {
    yield CalendarLoadingState();

    Appointment nearestAppointment = await _service.getNearestAppointment();

    yield nearestAppointment;
  }

  Stream<CalendarState> _performChangeVisibleDates(ChangeVisibleDatesEvent event) async* {
    yield CalendarLoadingState();

    await _service.changeVisibleDates(event.from);
  }
}
