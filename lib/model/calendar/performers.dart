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

class AddAppointmentPerformer extends FuturePerformer<Appointment, AddAppointment> {
  AddAppointmentPerformer(this._service);
  final AppointmentsRepository _service;

  @override
  Future<Appointment> perform(AddAppointment change) =>
      _service.addAppointment(change.selectedDay);
}

class RemoveAppointmentPerformer extends FuturePerformer<Appointment, RemoveAppointment> {
  RemoveAppointmentPerformer(this._service);
  final AppointmentsRepository _service;

  @override
  Future<Appointment> perform(RemoveAppointment change) =>
      _service.removeAppointment(change.selectedDay);
}