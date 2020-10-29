import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yadonor/domain/appointment-item.dart';
import 'package:yadonor/data/calendar/appointments_service.dart';

abstract class AppointmentsEvent {}

class FetchAppointmentsEvent extends AppointmentsEvent {}

class AppointmentsState {}

class AppointmentsLoadInProgress extends AppointmentsState {}

class AppointmentsLoadSuccess extends AppointmentsState {}

class AppointmentsErrorState extends AppointmentsState {}

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  List<Appointment> appointments;

  final AppointmentsService _service = AppointmentsService();

  AppointmentsBloc(AppointmentsState initialState) : super(initialState);

  @override
  Stream<AppointmentsState> mapEventToState(AppointmentsEvent event) {
    if (event is FetchAppointmentsEvent) {
      return _performFetchAppointments(event);
    } else {
      throw UnimplementedError();
    }
  }

  Stream<AppointmentsState> _performFetchAppointments(
      FetchAppointmentsEvent event) async* {
    yield AppointmentsLoadInProgress();

    List<Appointment> fetchedAppointments = await _service.fetchAppointments();

    if (fetchedAppointments != null) {
      appointments = fetchedAppointments;
    } else {
      yield AppointmentsErrorState();
    }
  }

  Stream<List<Appointment>> appointmentsChange() async* {
    yield appointments;
  }
}
