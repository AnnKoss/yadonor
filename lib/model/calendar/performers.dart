import 'package:surf_mwwm/surf_mwwm.dart';

import 'package:yadonor/data/appointment-item.dart';
import 'package:yadonor/model/calendar/changes.dart';
import 'package:yadonor/model/calendar/repository/calendar_repository.dart';

class GetAppointmentsPerformer
    extends FuturePerformer<List<Appointment>, GetAppointments> {
  GetAppointmentsPerformer(this._service);
  final AppointmentsRepository _service;

  @override
  Future<List<Appointment>> perform(GetAppointments change) =>
      _service.getAppointments();
}

class AddAppointmentPerformer extends FuturePerformer<void, AddAppointment> {
  AddAppointmentPerformer(this._service, this.selectedDay);
  final AppointmentsRepository _service;
  final DateTime selectedDay;

  @override
  Future<void> perform(AddAppointment change) =>
      _service.addAppointment(selectedDay);
}