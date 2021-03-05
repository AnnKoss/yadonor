import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

import 'package:yadonor/ui/calendar/calendar_screen_wm.dart';
import 'package:yadonor/data/appointment-item.dart';
import 'package:yadonor/ui/common/appointment_card.dart';

///List of future, past or present [Appointment] for calendar_screen.dart according to [FilterType].
class AppointmentListFiltered extends StatefulWidget {
  final List<Appointment> appointments;
  final List<Appointment> currentMonthAppointments;
  final void Function(DateTime) onRemoveAppointmentTap;
  final FilterType appointmentsFilter;
  AppointmentListFiltered(
    this.appointments,
    this.currentMonthAppointments,
    this.onRemoveAppointmentTap,
    this.appointmentsFilter,
  );

  @override
  _AppointmentListFilteredState createState() =>
      _AppointmentListFilteredState();
}

class _AppointmentListFilteredState extends State<AppointmentListFiltered> {
  @override
  Widget build(BuildContext context) {
    print('build AppointmentListFiltered');

    List<Appointment> getFutureAppointments() {
      return widget.appointments.where(
        (entry) {
          return entry.day.isAfter(DateTime.now());
        },
      ).toList();
    }

    List<Appointment> getPastAppointments() {
      return widget.appointments.where(
        (entry) {
          return entry.day.isBefore(DateTime.now());
        },
      ).toList();
    }

    String appointmentsText = 'Донации в этом месяце:';

    List<Appointment> displayedAppointments = widget.currentMonthAppointments;

    print('AppointmentListFiltered displayedAppointments: ' +
        displayedAppointments.toString());

    switch (widget.appointmentsFilter) {
      case FilterType.future:
        displayedAppointments = getFutureAppointments();
        appointmentsText = 'Предстоящие донации:';
        break;
      case FilterType.past:
        displayedAppointments = getPastAppointments();
        appointmentsText = 'Прошедшие донации:';
        break;
      case FilterType.current:
        displayedAppointments = widget.currentMonthAppointments;
        // print(displayedAppointments);
        break;
      default:
        displayedAppointments = widget.currentMonthAppointments;
        appointmentsText = 'Донации в этом месяце:';
        // print(displayedAppointments);
        break;
    }

    print('displayedAppointments: ' + displayedAppointments.toString());

    return (displayedAppointments.isNotEmpty)
        ? Column(
            children: <Widget>[
              Container(
                child: Text(
                  appointmentsText,
                  style: TextStyle(fontSize: 20),
                ),
                margin: EdgeInsets.only(top: 10),
              ),
              Expanded(
                child: Scrollbar(
                  child: ListView(
                    children: displayedAppointments
                        .map(
                          (appointment) => Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            elevation: 3,
                            child: AppointmentCard(
                              appointment: appointment,
                              hasCloseIcon: true,
                              onRemoveButtonPressed: (day) => widget
                                  .onRemoveAppointmentTap(appointment.day),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          )
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(
              'Выберите дату и нажмите "+", чтобы добавить донацию',
              style: TextStyle(
                color: Colors.grey,
                // fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          );
  }
}
