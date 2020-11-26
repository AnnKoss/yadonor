import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yadonor/domain/appointment-item.dart';
import 'package:yadonor/ui/appointment_card.dart';
import 'package:yadonor/ui/calendar/appointments_bloc.dart';
import 'package:yadonor/ui/calendar/calendar_screen.dart';

///List of future, past or present [Appointment] for calendar_screen.dart according to [FilterType].
class AppointmentListFiltered extends StatefulWidget {
  final FilterType appointmentsFilter;
  final DateTime firstVisibleDate;

  AppointmentListFiltered(this.appointmentsFilter, this.firstVisibleDate);

  @override
  _AppointmentListFilteredState createState() =>
      _AppointmentListFilteredState();
}

class _AppointmentListFilteredState extends State<AppointmentListFiltered> {
  @override
  Widget build(BuildContext context) {
    String appointmentsText = 'Донации в этом месяце:';

    return BlocBuilder<AppointmentsBloc, AppointmentsState>(
        builder: (context, state) {
      if (state is AppointmentsLoadingState) {
        // context.watch<AppointmentsBloc>.add(GetAppointmentsEvent());
        return CircularProgressIndicator();
      }
      if (state is AppointmentsLoadedState) {
        print(state.appointmentsList.appointments);
        List<Appointment> displayedAppointments =
            state.appointmentsList.currentMonthAppointments(widget.firstVisibleDate);

        switch (widget.appointmentsFilter) {
          case FilterType.future:
            displayedAppointments = state.appointmentsList.futureAppointments;
            appointmentsText = 'Предстоящие донации:';
            break;
          case FilterType.past:
            displayedAppointments = state.appointmentsList.pastAppointments;
            appointmentsText = 'Прошедшие донации:';
            break;
          case FilterType.current:
            displayedAppointments = state.appointmentsList
                .currentMonthAppointments(widget.firstVisibleDate);
            // print(displayedAppointments);
            break;
          default:
            displayedAppointments = state.appointmentsList
                .currentMonthAppointments(widget.firstVisibleDate);
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
                                    onRemoveButtonPressed: () {
                                      print(
                                          'calendar_screen appointment removed');
                                      context.read<AppointmentsBloc>().add(
                                          RemoveAppointmentEvent(
                                              appointment.day));
                                      // context.read<AppointmentsBloc>().add(GetAppointmentsEvent());  
                                    }),
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
      return const Text('Something went wrong!');
    });
  }
}
