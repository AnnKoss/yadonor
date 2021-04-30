import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yadonor/data/calendar/appointments_service.dart';
import 'package:yadonor/domain/appointment-item.dart';
import 'package:yadonor/domain/appointments_state_class.dart';

///Chooses whether to show events of the current month, all the future or all the past ones.
enum FilterType { future, past, current }

abstract class AppointmentsEvent {}

class GetAppointmentsEvent extends AppointmentsEvent {}

class AddAppointmentEvent extends AppointmentsEvent {
  final DateTime selectedDay;
  AddAppointmentEvent(this.selectedDay);
}

class RemoveAppointmentEvent extends AppointmentsEvent {
  final DateTime removeDay;
  RemoveAppointmentEvent(this.removeDay);
}

class ChangeVisibleDatesEvent extends AppointmentsEvent {
  final DateTime from;
  ChangeVisibleDatesEvent(this.from);
}

class SelectFilterEvent extends AppointmentsEvent {
  final FilterType filter;
  SelectFilterEvent(this.filter);
}

class AppointmentsState {}

class AppointmentsLoadingState extends AppointmentsState {}

class AppointmentsLoadedState extends AppointmentsState {
  final Appointments appointments;
  AppointmentsLoadedState(this.appointments);
}

class AppointmentsErrorState extends AppointmentsState {
  final String errorMessage;
  AppointmentsErrorState(this.errorMessage);
}


class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  final AppointmentsRepository _service;
  AppointmentsBloc(AppointmentsState initialState, this._service)
      : super(initialState);

  @override
  Stream<AppointmentsState> mapEventToState(AppointmentsEvent event) {
    if (event is GetAppointmentsEvent) {
      return _performGetAppointments(event);
    } else if (event is AddAppointmentEvent) {
      return _performAddAppointment(event);
    } else if (event is RemoveAppointmentEvent) {
      return _performRemoveAppointment(event);
    } else if (event is ChangeVisibleDatesEvent) {
      return _performChangeVisibleDates(event);
    } else if (event is SelectFilterEvent) {
      return _performSelectFilter(event);
    } else {
      throw UnimplementedError();
    }
  }

  /// The first date visible on the screen of current month. Used for changing displayed current month appointments in appointment_list_filtered.dart.
  DateTime firstVisibleDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    1,
  );

  FilterType appointmentsFilter = FilterType.current;

  Stream<AppointmentsState> _performGetAppointments(
      GetAppointmentsEvent event) async* {
    yield AppointmentsLoadingState();

    List<Appointment> loadedAppointments;
    try {
      loadedAppointments = await _service.getAppointments();

      print('loadedAppointments: $loadedAppointments');
    } on Exception {
      yield AppointmentsErrorState(
        'Не удалось загрузить список донаций.',
      );
    }

    yield AppointmentsLoadedState(
      Appointments(
        appointmentsList: loadedAppointments,
        firstVisibleDate: firstVisibleDate,
        filter: appointmentsFilter,
      ),
    );
  }

  Stream<AppointmentsState> _performAddAppointment(
      AddAppointmentEvent event) async* {
    yield AppointmentsLoadingState();

    List<Appointment> updatedList;
    try {
      updatedList = await _service.addAppointment(event.selectedDay);
    } on Exception {
      yield AppointmentsErrorState(
        'Не удалось добавить донацию.',
      );
    }

    yield AppointmentsLoadedState(
      Appointments(
        appointmentsList: updatedList,
        firstVisibleDate: firstVisibleDate,
        filter: appointmentsFilter,
      ),
    );
  }

  Stream<AppointmentsState> _performRemoveAppointment(
      RemoveAppointmentEvent event) async* {
    yield AppointmentsLoadingState();

    List<Appointment> updatedList;
    try {
      updatedList = await _service.removeAppointment(event.removeDay);
    } on Exception {
      yield AppointmentsErrorState(
        'Не удалось удалить донацию.',
      );
    }

    yield AppointmentsLoadedState(
      Appointments(
        appointmentsList: updatedList,
        firstVisibleDate: firstVisibleDate,
        filter: appointmentsFilter,
      ),
    );
  }

  Stream<AppointmentsState> _performSelectFilter(
      SelectFilterEvent event) async* {
    appointmentsFilter = event.filter;
    List<Appointment> appointmentsList = await _service.getAppointments();
    yield AppointmentsLoadedState(
      Appointments(
        appointmentsList: appointmentsList,
        firstVisibleDate: (event.filter == FilterType.current)
            ? DateTime(
                DateTime.now().year,
                DateTime.now().month,
                1,
              )
            : firstVisibleDate,
        filter: event.filter,
      ),
    );
  }

  Stream<AppointmentsState> _performChangeVisibleDates(
      ChangeVisibleDatesEvent event) async* {
    firstVisibleDate = event.from;
    List<Appointment> appointmentsList = await _service.getAppointments();
    yield AppointmentsLoadedState(
      Appointments(
        appointmentsList: appointmentsList,
        firstVisibleDate: event.from,
        filter: appointmentsFilter,
      ),
    );
  }
}
