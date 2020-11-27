import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yadonor/data/calendar/appointments_service.dart';
import 'package:yadonor/domain/appointment-item.dart';
import 'package:yadonor/domain/appointments.dart';

abstract class AppointmentsEvent {}

class AddAppointmentEvent extends AppointmentsEvent {
  DateTime selectedDay;

  AddAppointmentEvent(this.selectedDay);
}

class RemoveAppointmentEvent extends AppointmentsEvent {
  DateTime day;

  RemoveAppointmentEvent(this.day);
}

class GetAppointmentsEvent extends AppointmentsEvent {}

// class SelectDayEvent extends AppointmentsEvent {
//   DateTime day;
//   List<Appointment> appointments;

//   SelectDayEvent(this.day, this.appointments);
// }

// class ChangeVisibleDatesEvent extends AppointmentsEvent {
//   DateTime from;
//   DateTime to;
//   CalendarFormat format;

//   ChangeVisibleDatesEvent(this.from, this.to, this.format);
// }

// class GetNearestAppointmentEvent extends AppointmentsEvent {}

class AppointmentsState {}

class AppointmentsLoadingState extends AppointmentsState {}

class AppointmentsLoadedState extends AppointmentsState {
  final AppointmentsList appointmentsList;
  AppointmentsLoadedState({@required this.appointmentsList});

  @override
  String toString() {
    // TODO: implement toString
    if (appointmentsList != null) {
      return appointmentsList.appointments.toString();
    }
    return 'null';
  }
}

class AppoitmentsErrorState extends AppointmentsState {}

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  final AppointmentsRepository _service;

  // List<Appointment> appointments = [];

  AppointmentsBloc(AppointmentsState initialState, this._service)
      : super(initialState);

  @override
  Stream<AppointmentsState> mapEventToState(AppointmentsEvent event) {
    print('AppointmentBloc event: ' + event.toString());
    if (event is AddAppointmentEvent) {
      return _performAddAppointment(event, state);
    } else if (event is RemoveAppointmentEvent) {
      return _performRemoveAppointment(event, state);
    } else if (event is GetAppointmentsEvent) {
      return _performGetAppointments(event);
      // } else if (event is SelectDayEvent) {
      //   return _performSelectDay(event);
      // } else if (event is ChangeVisibleDatesEvent) {
      //   return _performChangeVisibleDates(event);
      // } else if (event is GetNearestAppointmentEvent) {
      //   return _performGetNearestAppointment(event);
    } else {
      throw UnimplementedError();
    }
  }

  List<Appointment> loadedAppointments;

  int Function(Appointment, Appointment) appointmentComparator = (a, b) {
    return a.day.compareTo(b.day);
  };

  Stream<AppointmentsState> _performAddAppointment(
      AddAppointmentEvent event, AppointmentsState state) async* {
    yield AppointmentsLoadingState();

    try {
      await _service.addAppointment(event.selectedDay);
    } on Exception {
      yield AppoitmentsErrorState();
    }

    loadedAppointments.add(Appointment(
      event.selectedDay,
      'Донорство крови',
    ));

    loadedAppointments.sort(appointmentComparator);

    // sortAppointments(loadedAppointments);

    AppointmentsLoadedState appointmentsLoadedState = AppointmentsLoadedState(
      appointmentsList: AppointmentsList(appointments: loadedAppointments),
    );

    print('bloc _performAddAppointment appointmentsLoadedState: ' +
        appointmentsLoadedState.appointmentsList.appointments.toString());
    print(appointmentsLoadedState.appointmentsList.appointments.length
            .toString() +
        ' - number of state appointments after adding');

    yield appointmentsLoadedState;
  }

  Stream<AppointmentsState> _performRemoveAppointment(
      RemoveAppointmentEvent event, AppointmentsState state) async* {
    yield AppointmentsLoadingState();

    try {
      await _service.removeAppointment(event.day);
    } on Exception {
      yield AppoitmentsErrorState();
    }

    // final Appointment selectedAppointment = loadedAppointments
    //     .firstWhere((appointment) => appointment.day == event.day);

    loadedAppointments
        .removeWhere((appointment) => appointment.day == event.day);

    AppointmentsLoadedState appointmentsLoadedState = AppointmentsLoadedState(
      appointmentsList: AppointmentsList(appointments: loadedAppointments),
    );

    print(appointmentsLoadedState.appointmentsList.appointments.length
            .toString() +
        ' - number of state appointments after deleting');

    yield appointmentsLoadedState;
  }

  Stream<AppointmentsState> _performGetAppointments(
      GetAppointmentsEvent event) async* {
    yield AppointmentsLoadingState();

    if (loadedAppointments == null) {
      loadedAppointments = await _service.getAppointments()
        ..sort(appointmentComparator);
    }

    // sortAppointments(loadedAppointments);

    print('loadedAppointments: ' + loadedAppointments.toString());

    AppointmentsLoadedState appointmentsLoadedState = AppointmentsLoadedState(
        appointmentsList: AppointmentsList(appointments: loadedAppointments));

    print('bloc _performGetAppointments appointmentsLoadedState: ' +
        appointmentsLoadedState.appointmentsList.appointments.toString());
    print(appointmentsLoadedState.appointmentsList.appointments.length
            .toString() +
        ' - number of state appointments');

    yield appointmentsLoadedState;
  }

  // Stream<AppointmentsState> _performSelectDay(SelectDayEvent event) async* {
  //   yield AppointmentsLoadingState();
  //   if (event.day != null) {
  //     await _service.selectDay(event.day, event.appointments);
  //   } else {
  //     yield AppoitmentsErrorState();
  //   }
  // }

  // Stream<AppointmentsState> _performGetNearestAppointment(GetNearestAppointmentEvent event) async* {
  //   yield AppointmentsLoadingState();

  //   Appointment nearestAppointment = await _service.getNearestAppointment();

  //   yield nearestAppointment;
  // }

  // Stream<AppointmentsState> _performChangeVisibleDates(ChangeVisibleDatesEvent event) async* {
  //   yield AppointmentsLoadingState();

  //   await _service.changeVisibleDates(event.from);
  // }
}
