import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yadonor/domain/appointment-item.dart';
import 'package:yadonor/ui/common/appointment_card.dart';
import 'package:yadonor/ui/calendar_screen/appointments_bloc.dart';
import 'package:yadonor/ui/common/button.dart';
import 'package:yadonor/ui/common/defauld_alert_dialog.dart';

///List of future, past or present [Appointment] for calendar_screen.dart according to [FilterType].
class AppointmentListFiltered extends StatefulWidget {
  final FilterType appointmentsFilter;
  final DateTime firstVisibleDate;
  AppointmentListFiltered(
    this.appointmentsFilter,
    this.firstVisibleDate,
  );

  @override
  _AppointmentListFilteredState createState() =>
      _AppointmentListFilteredState();
}

class _AppointmentListFilteredState extends State<AppointmentListFiltered> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentsBloc, AppointmentsState>(
      builder: (
        context,
        state,
      ) {
        if (state is AppointmentsLoadedState) {
          return (state
                  .appointments.filteredAppointments.appointments.isNotEmpty)
              ? Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        state
                            .appointments.filteredAppointments.appointmentsText,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      margin: const EdgeInsets.only(
                        top: 10,
                      ),
                    ),
                    Expanded(
                      child: Scrollbar(
                        child: ListView(
                          children: state
                              .appointments.filteredAppointments.appointments
                              .map(
                                (appointment) => Card(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 5,
                                  ),
                                  elevation: 3,
                                  child: AppointmentCard(
                                    appointment: appointment,
                                    hasCloseIcon: true,
                                    onRemoveButtonPressed: () {
                                      context.read<AppointmentsBloc>().add(
                                            RemoveAppointmentEvent(
                                              appointment.day,
                                            ),
                                          );
                                    },
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
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 40,
                  ),
                  child: const Text(
                    'Выберите дату и нажмите "+", чтобы добавить донацию',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
        }
        return DefaultAlertDialog();
      },
    );
  }
}
