import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:yadonor/data/appointment-item.dart';

class GetAppointments extends FutureChange<List<Appointment>> {}

class AddAppointment extends FutureChange<void> {
  final DateTime selectedDay;
  AddAppointment(this.selectedDay);
}

class RemoveAppointment extends FutureChange<void> {
  final DateTime selectedDay;
  RemoveAppointment(this.selectedDay);
}